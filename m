Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUDGRAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUDGRAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:00:44 -0400
Received: from codepoet.org ([166.70.99.138]:2717 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263740AbUDGRAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:00:43 -0400
Date: Wed, 7 Apr 2004 11:00:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Roy Franz <roy@royfranz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: probable Linux Kernel GPL violation
Message-ID: <20040407170010.GA3067@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Roy Franz <roy@royfranz.com>, linux-kernel@vger.kernel.org
References: <40743064.1030106@royfranz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40743064.1030106@royfranz.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 07, 2004 at 09:46:28AM -0700, Roy Franz wrote:
> If you would like to look at the firmware yourself, you can download it
> from:
> http://www.claxan.ch/de/prod_det-driver.asp?TOPNAVID=-1
> or
> http://support.trittontechnologies.com/downloads.html
> 
> See http://www.royfranz.com/Hacking_the_Tritton_NAS120.html for more
> info on what is inside the box hardware-wise, as well as a utility to
> unpack the firmware into the kernel image and an ext2 ramdisk image.
> There is other GPL and LGPL software runnning on the box - at least
> busybox, uclibc, samba, and probably others.

<busybox and uclibc maintainer hat on>
I've added the NAS120 to the BusyBox Hall of Shame...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
