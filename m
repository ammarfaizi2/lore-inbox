Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSGNVAe>; Sun, 14 Jul 2002 17:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSGNVAd>; Sun, 14 Jul 2002 17:00:33 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:44005 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S317278AbSGNVAd>; Sun, 14 Jul 2002 17:00:33 -0400
Date: Sun, 14 Jul 2002 17:09:35 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Sean Neakums <sneakums@zork.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <20020714205451.GD9202@zork.net>
Message-ID: <Pine.LNX.4.33.0207141707430.21492-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it was due to trying to put many thousands of files into a single flat
> directory.

exactly.  ext2 (and many other FSs) are simply not designed for obscenely
large directories.  it's unclear why Joerg brought up this rather obvious strawman.

