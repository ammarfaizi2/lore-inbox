Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273610AbRIUQZl>; Fri, 21 Sep 2001 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273601AbRIUQZd>; Fri, 21 Sep 2001 12:25:33 -0400
Received: from a82d11hel.dial.kolumbus.fi ([212.54.29.82]:20530 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S273604AbRIUQZT>; Fri, 21 Sep 2001 12:25:19 -0400
Message-ID: <3BAB69CF.A3F9D217@kolumbus.fi>
Date: Fri, 21 Sep 2001 19:24:47 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roger Larsson <roger.larsson@norran.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Stefan Westerfeld <stefan@space.twc.de>, Robert Love <rml@tech9.net>,
        Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Sound cards have a lot of buffering, we are talking 64-128Kbytes + on 
> card buffers. Thats 0.25-0.5 seconds at 48Khz 16bit stereo

Only "soundcards", that cheap crap like SoundBlaster. Professional
lowlatency soundcards usually have something like 128-512 samples per
channel for 24-bit (32-bit data) 96 kHz 8 channels...

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
