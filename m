Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTDLMLE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 08:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTDLMLE (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 08:11:04 -0400
Received: from lists.asu.edu ([129.219.13.98]:15769 "EHLO lists.asu.edu")
	by vger.kernel.org with ESMTP id S263259AbTDLMLD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 08:11:03 -0400
Date: Sat, 12 Apr 2003 05:22:48 -0700 (MST)
From: Shesha@asu.edu
Subject: Re: readprofile: Length of procedure
In-reply-to: <Pine.GSO.4.21.0304120512570.19783-100000@general3.asu.edu>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304120519540.19858-100000@general3.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello Linux ppl,
 
 In the readprofile man page load=(# of clk ticks) / (length of the procedure)
 
 What does "length of procedure" means. Does that mean the # of ASM lines of
 the procedure code? What is the units of the load. It cannot be %. because 
-----------------------------------------------------------
 152495 default_idle                             3176.9792 
-----------------------------------------------------------
 the above line indicate tha more than 100% of times CPU is idle. This cannot
happen.
 
 -Shesha
 
 
 
 

