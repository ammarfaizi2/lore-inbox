Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVC3VQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVC3VQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVC3VPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:15:19 -0500
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:53910 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261175AbVC3VNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:13:31 -0500
Date: Wed, 30 Mar 2005 14:13:46 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, seife@suse.de,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: smp/swsusp done right
In-Reply-To: <20050323204019.GA11616@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
References: <20050323204019.GA11616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Pavel Machek wrote:

> This is against -mm kernel; it is smp swsusp done right, and it
> actually works for me. Unlike previous hacks, it uses cpu hotplug
> infrastructure. Disable CONFIG_MTRR before you try this...
> 
> Test this if you can, and report any problems. If not enough people
> scream, this is going to -mm.

Yay! Thanks for getting that done Pavel =)

	Zwane

