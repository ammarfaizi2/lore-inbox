Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVBGCJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVBGCJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 21:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVBGCJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 21:09:34 -0500
Received: from www.missl.cs.umd.edu ([128.8.126.38]:33042 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S261336AbVBGCJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 21:09:32 -0500
Date: Sun, 6 Feb 2005 21:11:18 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung
 P35, S3, black screen (radeon))
In-Reply-To: <1107695583.14847.167.camel@localhost.localdomain>
Message-ID: <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net>
 <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz> 
 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> 
 <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>
  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>
  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,
 	I would like point to work done by Li-Ta Lo.

 	It allows you to completely initalize the VGA BIOS w/out using
 	PC BIOS at all.

 	http://www.clustermatic.org/pipermail/linuxbios/2005-January/010236.html

 	unforunatelly the information the web is somewhat sparse, but
 	you can get more info by following the archive of the
 	thread (which head I listed above) and perhaps by posting to
 	linuxbios mailing list (Ollie, is somewhat buy those days with his
 	new baby).

 	Either way quite amazing feat that should bring LinuxBIOS closer
 	to desktop.

