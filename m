Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVBSBQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVBSBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVBSBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:16:56 -0500
Received: from smtp7.wanadoo.fr ([193.252.22.24]:39578 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261604AbVBSBQu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:16:50 -0500
X-ME-UUID: 20050219011649436.6A9A81C00083@mwinf0708.wanadoo.fr
Subject: Re: 2.6: drivers/input/power.c is never built
From: Xavier Bestel <xavier.bestel@free.fr>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       dtor_core@ameritech.net, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502190051.48052.oliver@neukum.org>
References: <047401c515bb$437b5130$0f01a8c0@max>
	 <200502182300.21420.oliver@neukum.org> <20050218233443.GB1628@elf.ucw.cz>
	 <200502190051.48052.oliver@neukum.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 19 Feb 2005 02:16:28 +0100
Message-Id: <1108775788.11120.13.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 19 février 2005 à 00:51 +0100, Oliver Neukum a écrit :

> > Well, we can say that userspace definitely is interested in "power"
> > key ;-).
> 
> I wouldn't call that selfevident. The system might be eg. a ticket
> vending system and we care only about wake ups from touchscreen,
> trackball and modem and about volume control keys. I don't think
> you can make up any rules about what user space is interested or not.

If noone can tell in advance who will be interested and what to do with
it, that looks like a very good reason to go through userspace ..

	Xav


