Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316643AbSFDTur>; Tue, 4 Jun 2002 15:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSFDTuq>; Tue, 4 Jun 2002 15:50:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:31391 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316643AbSFDTup>;
	Tue, 4 Jun 2002 15:50:45 -0400
Date: Tue, 4 Jun 2002 14:06:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 -- suspend.c still breaks the build (originally reported for 2.5.18)
Message-ID: <20020604140622.A36@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <1023073620.1685.10.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> suspend.c: In function signal_wake_up'
> suspend.c: In function do_suspend_sync':
> suspend.c:306: 
