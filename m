Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUKPXT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUKPXT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKPXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:17:52 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:11449 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261889AbUKPXPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:15:54 -0500
Message-ID: <419A8A27.3040102@verizon.net>
Date: Tue, 16 Nov 2004 18:15:51 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: A M <alim1993@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: [OT]Re: Accessing program counter registers from within C or Aseembler.
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
In-Reply-To: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Tue, 16 Nov 2004 17:15:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A M wrote:
> Hello, 
> 
> Does anybody know how to access the address of the
> current executing instruction in C while the program
> is executing? 
> 
> Also, is there a method to load a program image from
> memory not a file (an exec that works with a memory
> address)? Mainly I am looking for a method that brings
> a program image into memory modify parts of it and
> start the in-memory modified version. 
> 
> Can anybody think of a method to replace a thread
> image without replacing the whole process image? 
> 
> Thanks, 
> 
> Ali
> 

The Shellcoder's Handbook is probably the best book out there on the kind of stuff 
you're talking about.  Just be prepared - it's written on a rather advanced level.
