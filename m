Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUCGPIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUCGPIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 10:08:10 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:1805 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262079AbUCGPIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 10:08:09 -0500
Date: Sun, 7 Mar 2004 16:08:07 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Carlo Orecchia <carlo@numb.darktech.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL 2.6.3 and MAXTOR 160 GB
Message-ID: <20040307150807.GA16436@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0403071549260.3262-100000@numb.darktech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403071549260.3262-100000@numb.darktech.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 03:57:11PM +0100, Carlo Orecchia wrote:

> I'm running redhat 9 on an XP 1800 and a ASUS A7A266. I recently buy a new 
> HD a maxtor Diamond Plus 160 with 8 mega cache. The fact is that the kernel that comes 
> with REDHAT (2.4.20-8) shows the entire size of the disk (163.7 gb) but 
> the kernel 2.6.1 or 2.6.3 does not. It only shows 137 gb. I'm getting 
> crazy trying to understand why this is happening! Please let 
> me know if theres a patch to fix this. I really  found amazing the 2.6 
> kernel and i don't want to come back to use the 2.4!
> What can i do? 

You can tell us the boot messages that concern your disk.
You can tell us the CONFIG options that concern IDE.
For example, did you set CONFIG_IDEDISK_STROKE ?

