Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264417AbSIVRQB>; Sun, 22 Sep 2002 13:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264425AbSIVRQB>; Sun, 22 Sep 2002 13:16:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11534 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264417AbSIVRQB>; Sun, 22 Sep 2002 13:16:01 -0400
Date: Sun, 22 Sep 2002 10:22:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Waechtler <pwaechtler@mac.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/11 sound/oss replace cli() 
In-Reply-To: <ED015C41-CDA0-11D6-8873-00039387C942@mac.com>
Message-ID: <Pine.LNX.4.44.0209221020470.10598-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Sep 2002, Peter Waechtler wrote:
>
> This is a resent with a correction of dmasound_q40.c - I don't touch the
> IRQ handler anymore.

All of your patches are seriously whitespace-damaged: lines word-wrapped, 
whitespace at end-of-line removed etc etc.

Either your mail script is broken again, or Apple Mail is crud.

		Linus

