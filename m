Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTDNWGb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTDNWGb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:06:31 -0400
Received: from post2.inre.asu.edu ([129.219.110.73]:21916 "EHLO
	post2.inre.asu.edu") by vger.kernel.org with ESMTP id S263772AbTDNWG3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:06:29 -0400
Date: Mon, 14 Apr 2003 15:15:51 -0700 (MST)
From: Shesha@asu.edu
Subject: readprofile: Meaning of "Length of procedure"
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304141510330.3054-100000@general2.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello Linux ppl,
 
 I have copuple of questions, I request you to share the information if you
know ....
--
1
--
 In the readprofile man page load=(# of clk ticks) / (length of the procedure)
 
 What does "length of procedure" means. Does that mean the # of ASM lines of
 the procedure code? What is the units of the load. It cannot be %. because 
-----------------------------------------------------------
 152495 default_idle                             3176.9792 
-----------------------------------------------------------
 the above line indicates,  more than 100% of times CPU is idle. This cannot
happen.
 
--
2
--
 What value of the procedure load is considered to be a potential CPU
intensive procedure/ high load procedure.

Say for example, if the load value is 20, then is that procedure considered to
be a high load procedure. 

Thanking You
Shesha
 
 
 
 


