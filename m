Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTAaTqy>; Fri, 31 Jan 2003 14:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTAaTqy>; Fri, 31 Jan 2003 14:46:54 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:61582 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S262040AbTAaTqx>; Fri, 31 Jan 2003 14:46:53 -0500
Date: Fri, 31 Jan 2003 14:55:09 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Perl in the toolchain
In-Reply-To: <20030131194837.GC8298@gtf.org>
Message-ID: <Pine.LNX.4.53.0301311452270.14554@filesrv1.baby-dragons.com>
References: <20030131133929.A8992@devserv.devel.redhat.com>
 <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
 <20030131194837.GC8298@gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All,   And no one wanted python ?  I find the necessity for
	extraneous packages silly .  Perl for gods sake .  JimL my .02

On Fri, 31 Jan 2003, Jeff Garzik wrote:
> On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> > Generally, we've been trying to not make perl a prequisite for the kernel
> > build, and I'd like to keep it that way. Except for some arch specific
> That's pretty much out the window when klibc gets merged, so perl will
> indeed be a build requirement for all platforms...
> 	Jeff
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
