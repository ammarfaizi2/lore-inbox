Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTLWWlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLWWlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:41:03 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:17224 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262458AbTLWWlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:41:00 -0500
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.7 (future kernel) wish
Date: Tue, 23 Dec 2003 23:42:17 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312232342.17532.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all... Compliments about 2.6.0. It is a superb kernel, with very few 
serious bugs, and for me it runs stable like a rock from the very first 
moment.

As an end user, Linux doesn't give me a good feeling on one particular item 
yet: Error handling. 

What do I mean ? Well... for example: Pull out your USB stick with a mounted 
fs on it. Linux doesn't really seem to like it, got weird problems etc. It 
will survive, sure, but the user got no clue and data are lost for sure. Bad 
sectors on a disk... Linux will pass, but even 2.6.0 went very slow, 
unresponsive when a floppy with bad sectors went into the drive. Many other 
non-critical or solvable problems that are dealt with in a way that makes 
linux survive (most of the times), but not in a way that is neat from the 
user point of view.

It all just doesn't feel like Linux is doing the best it can to "rescue the 
user" when something is going wrong. Technically speaking, it's not only the 
task of the kernel to do so, but for an end user it makes the difference 
between an OS that does its job, and an OS that does its job nicely.

I think it's hard to describe what I mean exactly, but I hope you get the 
feeling. I too know that some of this is not within scope of the kernel (it's 
not the kernels task to tell the user "put back the USB drive or data is 
lost"), but after dealing with broken floppies again, I thought it was time 
to write my feelings to the list.

Best regards, and thanks for the wonderful world of Linux,

Jos

