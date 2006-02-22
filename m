Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWBVSNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWBVSNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWBVSNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:13:51 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38824
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751383AbWBVSNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:13:50 -0500
Date: Wed, 22 Feb 2006 10:13:55 -0800
From: Greg KH <gregkh@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kay.sievers@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] restore superblock mount/umount uevents
Message-ID: <20060222181355.GA12148@suse.de>
References: <1140631690.11447.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140631690.11447.2.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:08:09PM +0200, Pekka Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch fixes an userspace regression caused by "[PATCH] remove
> mount/umount uevents from superblock handling" where gnome-volume-manager no
> longer detects plugged in devices. You can find a complete bug description
> here: http://bugzilla.kernel.org/show_bug.cgi?id=6021.
> 
> I have tested this patch on Gentoo Linux running HAL 0.5.5.1.

Heh, I sent this a few minutes before to Linus and lkml :)

thanks,

greg k-h
