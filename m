Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRKNUKo>; Wed, 14 Nov 2001 15:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKNUKe>; Wed, 14 Nov 2001 15:10:34 -0500
Received: from anime.net ([63.172.78.150]:50447 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277152AbRKNUK1>;
	Wed, 14 Nov 2001 15:10:27 -0500
Date: Wed, 14 Nov 2001 12:08:51 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Charles Marslett <cmarslett9@cs.com>
cc: Philippe Amelant <philippe.amelant@free.fr>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <3BF2A2A2.29021CF6@cs.com>
Message-ID: <Pine.LNX.4.30.0111141207430.24024-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Charles Marslett wrote:
> I agree, but the Thunderbirds (older 1.4 GHz processors) run hotter than anything
> else, so this may be normal.  My dual 1.2 GHz MPs run about 72C, and they are
> supposed to be a bit cooler than the Thunderbirds.  I don't have much in the
> way of cooling, though....

Thats far too hot. If youre using lm78, you need to change the sensor type
from the default to "2" or you get bogus readings.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

