Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbSKSQ4t>; Tue, 19 Nov 2002 11:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKSQ4c>; Tue, 19 Nov 2002 11:56:32 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:50836 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S265132AbSKSQ4P>; Tue, 19 Nov 2002 11:56:15 -0500
Date: Tue, 19 Nov 2002 18:03:17 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Karsten Desler <soohrt@soohrt.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119180317.A2597@pc9391.uni-regensburg.de>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net> <20021119113300.C23008@pc9391.uni-regensburg.de> <20021119152244.GA26989@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021119152244.GA26989@sit0.ifup.net>; from soohrt@soohrt.org on Tue, Nov 19, 2002 at 16:22:44 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2002   16:22 Karsten Desler wrote:
> ---
> 
> > When I'm back home in about 7 hours, I'll check my bios settings, maybe
> this
> > could help you.
> 
> That would be great, thanks.
> 
okay, my brain really shrinks; with only one hdd attached, you can't create an 
array. So here it seems to work out of the box. I just tried 2.4.20-rc-ac1, 
which detects my drive connected to that hpt374 (hde).

Maybe you can give this one a try?

Are using the latest BIOS for your mobo? About a week ago there was a new one 
posted, somewhere at epox.com...

Christian
