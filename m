Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbRF0MxD>; Wed, 27 Jun 2001 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265328AbRF0Mwx>; Wed, 27 Jun 2001 08:52:53 -0400
Received: from office-01.ops.asmr-01.energis-idc.net ([213.218.69.13]:18614
	"HELO cuddle.dds.nl") by vger.kernel.org with SMTP
	id <S265326AbRF0Mwe>; Wed, 27 Jun 2001 08:52:34 -0400
Date: Wed, 27 Jun 2001 14:52:26 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thrashing WITHOUT swap.
Message-ID: <20010627145226.P18733@cuddle.dds.nl>
Reply-To: ookhoi@dds.nl
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
User-Agent: Mutt/1.3.18i
X-Uptime: 17:19:10 up 42 min,  8 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej Zenczykowski,

> This is happening on a freshly installed RH7.1 notebook.
> Celeron 400 + 64 mb ram, kernel as shipped (2.4.2-2, have not even
> recompiled it yet).  I have a 140 mb swap partition set up but at the time
> this happened it was OFF.  I was (still am) running X + twm + two xterms
> with ssh + netscape (this is probably the cause of the entire problem).
> I had a single netscape window open with a mid-graphic intensive screen.
> The system started thrashing...  Now my question is how can it be
> thrashing with swap explicitly turned off? [oh just to make stuff even
> funnier netscape is at nice -19 (i.e. lower priority)]

nice -19 means high priority doesn't it? It is not nice towards other
processes.

	Ookhoi
