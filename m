Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTGPRLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTGPRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:10:35 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:31634 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270966AbTGPRJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:09:25 -0400
Date: Wed, 16 Jul 2003 18:23:31 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716172331.GD21896@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	vojtech@suse.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716171607.GM833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:16:07PM +0200, Jens Axboe wrote:

 > > > SG_IO, that way you can use dma (and zero copy) for the rips. That will
 > > > be lots more smooth.
 > > So why isnt this occuring on 2.4 .. thats the important question here is
 > > this a logging thing, a new input layer bug, an ide bug or what ?
 > Dave, have you tried 2.4 newest?

I've not booted a 2.4 kernel since 2.4.20..

 > Some of the newer IDE stuff kept
 > interrupts off for ages, maybe it's on 2.4 also.

I can try sometime if you want to know.. (I've got plenty more
CDs that need encoding, so I'll have plenty of opportunity to
see this bug if its there 8-)

 > Also Dave, can you try
 > and do a vmstat 1 while ripping and PS2 dropping out?

Ok, I just fired that up in another window.
When it happens next, I'll mail off a snapshot..

		Dave

