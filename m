Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130291AbRCBC2O>; Thu, 1 Mar 2001 21:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130301AbRCBC2E>; Thu, 1 Mar 2001 21:28:04 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:45336 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S130290AbRCBC1s>; Thu, 1 Mar 2001 21:27:48 -0500
Date: Thu, 1 Mar 2001 21:27:45 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2ac8 lost char devices
In-Reply-To: <20010302032450.A1014@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10103012127050.4143-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > Well, somethig has broken in ac8, because I lost my PS/2 mouse and
> > > > me too </aol>.
> No luck.

it seems to be the mdelay(2) added to pc_keyb.c in -ac6.

