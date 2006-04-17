Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWDQNcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWDQNcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDQNcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:32:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750956AbWDQNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:32:09 -0400
Subject: Re: Boot CDrom from grub
From: Arjan van de Ven <arjan@infradead.org>
To: Niklaus <niklaus@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <85e0e3140604170625k112680f8qd4ef96f7d3d3ea98@mail.gmail.com>
References: <85e0e3140604170625k112680f8qd4ef96f7d3d3ea98@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:32:04 +0200
Message-Id: <1145280724.2847.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 18:55 +0530, Niklaus wrote:
> Hi,
>  I have a bootable CD and normal ISO9660 data CD (linux non-bootable)
> , both has linux on it.
>  I don't have the BIOS password and hence cannot change the bios
> startup options.
> 
> 1) Is there any way to boot the CD from grub command line ?

if you are asking this to install a linux distro on your machine,
you can just copy the vmlinux and the initrd.img (Fedora names, but most
likely other distros have named these similar) to your /boot and add
these to grub.conf and boot them that way.

if you are asking this because you want to hack a system please go away.
 

