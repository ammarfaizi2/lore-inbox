Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSBMSko>; Wed, 13 Feb 2002 13:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSBMSke>; Wed, 13 Feb 2002 13:40:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288512AbSBMSkV>; Wed, 13 Feb 2002 13:40:21 -0500
Date: Wed, 13 Feb 2002 12:26:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <ac9410@bellsouth.net>,
        <alan@clueserver.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4 sound module problem
In-Reply-To: <E16awaG-0004sB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202131224410.1211-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, Alan Cox wrote:
>
> Waste of effort. ALSA will replace the OSS code anyway

In fact, in my tree it right now has replaced it. I'll make a pre-patch
and try to get the BK tree pushed out.

		Linus

