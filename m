Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUHIKYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUHIKYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHIKXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:23:36 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:18313 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266460AbUHIKWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:22:47 -0400
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
From: Marcel Holtmann <marcel@holtmann.org>
To: Filip Van Raemdonck <filipvr@xs4all.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809095425.GA12667@debian>
References: <20040808191912.GA620@elf.ucw.cz>
	 <1092003277.2773.45.camel@pegasus>  <20040809095425.GA12667@debian>
Content-Type: text/plain
Message-Id: <1092046959.21815.15.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 12:22:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filip,

> > > I'm using USB bluetooth dongle for connecting with my cell phone... It
> > > works in 2.6.7, but not in -rc2-mm1. Is that known?
> > 
> > not that I know of, but I need more details and first you should try the
> > latest 2.6.8-rc3
> 
> Works here for USB dongle <-> cell phone. Dunno about the others.
> So, it's not a general breakage (in that kernel version)

this is what I was thinking, because I always run the latest stuff from
the Bitkeeper repository directly. Seems that there is something in the
-mm patches that broke it. Can someone test the latest -mm and report if
the Bluetooth subsystem is working or not?

Regards

Marcel


