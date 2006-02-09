Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWBIXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWBIXbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWBIXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:31:20 -0500
Received: from mail.gmx.de ([213.165.64.21]:10178 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750801AbWBIXbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:31:19 -0500
Date: Fri, 10 Feb 2006 00:31:18 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.62.0602091520500.11317@schroedinger.engr.sgi.com>
Subject: Re: man-pages-2.23 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <10949.1139527878@www004.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > mbind.2
> 
> Does this include a description of the new flags MPOL_MF_MOVE and 
> MPOL_MF_MOVE_ALL? There is a manpage in Andi Kleen's numactl 0.9.2 that 
> describes these.

Not yet, because 2.6.16 (which adds these flags) is not yet 
released.  However, I have the material in my queue to be 
integrated when 2.6.16 is released.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
