Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSJVJvY>; Tue, 22 Oct 2002 05:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJVJvY>; Tue, 22 Oct 2002 05:51:24 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:55936 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262354AbSJVJvX> convert rfc822-to-8bit; Tue, 22 Oct 2002 05:51:23 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: bert hubert <ahu@ds9a.nl>
Subject: Re: PROBLEM: PCMCIA cardmgr kill hangs kernel
Date: Tue, 22 Oct 2002 11:51:16 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <200210221046.46700.Take.Vos@binary-magic.com> <20021022093410.GA2392@outpost.ds9a.nl>
In-Reply-To: <20021022093410.GA2392@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210221151.16523.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello bert,

> > kernel:	linux-2.5.43
> > cardmgr:	3.2.1
> > hardware:DELL Inspiron 8100
> > config:	CONFIG_PCMCIA
> > 		CONFIG_CARDUBS
> > 		CONFIG_BLK_DEV_IDECS
> >
> > killing the cardmgr hangs the kernel,
>
> How hard? Does numlock still work? Can you tell if the CPU is busy
> afterwards (ie, your laptop remains hot)
I did find out that it only happens when my compact flash card is insurted. 
Without it I can do a kill of the cardmgr.

I haven't checked numlock. But I can't switch consoles with alt+f?.

I'll do some more test this evening in the hotel.

-- 
Take Vos <Take.Vos@binary-magic.com>
GnuPG: 2A5C110609995A378302A27630C962CCFD54AA85
http://binary-magic.com/~takev/

