Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVKZByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVKZByE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVKZByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 20:54:04 -0500
Received: from systemlinux.org ([83.151.29.59]:15076 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S932712AbVKZByD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 20:54:03 -0500
Date: Sat, 26 Nov 2005 02:53:18 +0100
From: Andre Noll <maan@systemlinux.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Landley <rob@landley.net>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051126015318.GW26862@skl-net.de>
References: <200511170629.42389.rob@landley.net> <200511230258.33901.rob@landley.net> <20051123132106.GC23159@elf.ucw.cz> <200511232202.38294.rob@landley.net> <20051125194620.GB2164@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125194620.GB2164@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 20:46, Pavel Machek wrote:

> No, not it:
> 
> pavel@amd:~/sf/routeplanner$ ls -al /bin/sh
> lrwxrwxrwx  1 root root 4 Nov 22 15:01 /bin/sh -> bash

Even in that case '/bin/sh' and '/bin/bash' are not the same. From
the bash man page:

	If  bash  is invoked with the name sh, it tries to mimic
	the startup behavior of historical versions of sh as closely
	as possible...

Andre
-- 
Jesus not only saves, he also frequently makes backups
