Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTARUah>; Sat, 18 Jan 2003 15:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTARUah>; Sat, 18 Jan 2003 15:30:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:64914 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265058AbTARUag>;
	Sat, 18 Jan 2003 15:30:36 -0500
Date: Sat, 18 Jan 2003 12:40:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: harinath@cs.umn.edu, adam@yggdrasil.com, alsa-devel@alsa-project.org,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant
 errno variable
Message-Id: <20030118124051.2056dc64.akpm@digeo.com>
In-Reply-To: <20030118202723.GA27477@vana.vc.cvut.cz>
References: <20030117155717.A6250@baldur.yggdrasil.com>
	<d9n0lz18an.fsf@bose.cs.umn.edu>
	<20030118031319.GA19982@vana.vc.cvut.cz>
	<d9bs2e8o0b.fsf@bose.cs.umn.edu>
	<20030118202723.GA27477@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 20:39:21.0073 (UTC) FILETIME=[ADD84610:01C2BF31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> And as I do not have sound hardware which needs firmware, I do not
> want to make more changes than absolutely necessary to the code I cannot
> verify. Of course if you'll find someone with hardware...

Your patch was clearly an improvement on what was there, so I shall be
sending it in to Linus.  If it breaks then we will hear about it soon enough.


