Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264167AbRFODTX>; Thu, 14 Jun 2001 23:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264172AbRFODTN>; Thu, 14 Jun 2001 23:19:13 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:47548 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264167AbRFODS4>; Thu, 14 Jun 2001 23:18:56 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: John Cavan <johnc@damncats.org>
Subject: Re: Linux 2.4.5-ac14
Date: Fri, 15 Jun 2001 05:32:23 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010615022033Z261561-17720+4111@vger.kernel.org> <3B29734A.738A95D5@damncats.org>
In-Reply-To: <3B29734A.738A95D5@damncats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010615031906Z264167-17720+4114@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Juni 2001 04:30 schrieb John Cavan:
> Dieter Nützel wrote:
> > Hello Alan,
> >
> > I see 4.29 GB under shm with your latest try.
> > something wrong?
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  1053483008 431419392 622063616   122880 24387584 260923392
> Swap: 394764288        0 394764288
> MemTotal:      1028792 kB
> MemFree:        607484 kB
> MemShared:         120 kB
> Buffers:         23816 kB
> Cached:         254808 kB
> Active:         225536 kB
> Inact_dirty:     53208 kB
> Inact_clean:         0 kB
> Inact_target:       44 kB
> HighTotal:      131056 kB
> HighFree:         1048 kB
> LowTotal:       897736 kB
> LowFree:        606436 kB
> SwapTotal:      385512 kB
> SwapFree:       385512 kB
>
> I don't seem to have the problem...

You are using HIGHMEM?!

-Dieter
