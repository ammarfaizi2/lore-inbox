Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265044AbRFZRQm>; Tue, 26 Jun 2001 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbRFZRQa>; Tue, 26 Jun 2001 13:16:30 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:47640 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265044AbRFZRQW>;
	Tue, 26 Jun 2001 13:16:22 -0400
Message-ID: <20010626191625.A24397@win.tue.nl>
Date: Tue, 26 Jun 2001 19:16:25 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wrong disk index in /proc/stat
In-Reply-To: <20010626174942.A24389@win.tue.nl> <Pine.LNX.4.30.0106261840270.13052-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0106261840270.13052-100000@biker.pdb.fsc.net>; from Martin Wilck on Tue, Jun 26, 2001 at 06:55:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 06:55:54PM +0200, Martin Wilck wrote:

> I (being new to kernel hacking) have yet to understand what needs
> to happen for patches to enter the main branches.

You mail them to Linus, with a cc to linux-kernel.
If he likes the patch it will be part of the next (pre)release.
Since your patch is short and corrects an actual bug,
your chances may be good.
If Linus starts 2.5 and Alan takes 2.4 the patch may be
relevant to both branches.
