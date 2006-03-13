Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWCMUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWCMUJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCMUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:09:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:30391 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932413AbWCMUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:09:17 -0500
Date: Mon, 13 Mar 2006 21:09:10 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com,
       dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com,
       paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org,
       Tom Seeley <redhat@tomseeley.co.uk>, Jiri Slaby <jirislaby@gmail.com>,
       laredo@gnu.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Subject: Re: 2.6.16-rc6: known regressions
Message-ID: <20060313200910.GA11366@suse.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060313200544.GG13973@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 13, Adrian Bunk wrote:

> Subject    : 2.6.16-rc5-git14 crash in spin_bug on ppc64
> References : http://lkml.org/lkml/2006/3/10/190
> Submitter  : Olaf Hering <olh@suse.de>
> Status     : unknown

I have seen it only once, and I rebooted that kernel alot.
