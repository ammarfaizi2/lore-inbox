Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264554AbRFMGcu>; Wed, 13 Jun 2001 02:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264555AbRFMGcj>; Wed, 13 Jun 2001 02:32:39 -0400
Received: from ns.suse.de ([213.95.15.193]:14345 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264554AbRFMGc3>;
	Wed, 13 Jun 2001 02:32:29 -0400
Date: Wed, 13 Jun 2001 08:33:45 +0200 (CEST)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010613083154.6D88FAA5F@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jun, Linus Torvalds wrote:

> Yes. Although I hope it's going to be XvMPG2 or something - some cards
> literally do all of the mpeg2 stuff, not just parts of it, and
> limiting yourself to just the motion comp is limiting the protocol
> quite badly.

 I recompiled a complete X with the extended Xv ATI driver from GATOS
 (aka ati.2). After fixing a bug (well, checking from the presence of
 a BIOS to try to access it anyway doesn't really make sense and will
 crash on any non-i386) I still have the same endianess problems.
 Just to let you know....

Servus,
       Daniel

