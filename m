Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTK2MAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 07:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTK2MAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 07:00:23 -0500
Received: from mail.skjellin.no ([80.239.42.67]:28130 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262190AbTK2MAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 07:00:22 -0500
Subject: Re: bug in -test11 make xconfig
From: Andre Tomt <lkml@tomt.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031129112549.GD15782@triplehelix.org>
References: <200311292325.44935.csawtell@paradise.net.nz>
	 <20031129112549.GD15782@triplehelix.org>
Content-Type: text/plain
Message-Id: <1070107205.19921.12.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 13:00:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-29 at 12:25, Joshua Kwan wrote:
> On Sat, Nov 29, 2003 at 11:25:44PM +1300, Christopher Sawtell wrote:
> >   I have noticed that it is not possible to configure the kernel to use the 
> > xfs file system using the 'make xconfig' command.
> >   'make menuconfig' and 'make gconfig' appear to work correctly.
> 
> I assume this is a 2.5 or 2.6 kernel source you are talking about,
> since gconfig is unavailable in 2.4. Could you be more precise?

I guess the subject is precise enough, given the fact that 2.4 havn't
had -test releases since 2.4.0 :-)


