Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbRGMLMB>; Fri, 13 Jul 2001 07:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbRGMLLu>; Fri, 13 Jul 2001 07:11:50 -0400
Received: from pop.gmx.net ([194.221.183.20]:42830 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267023AbRGMLLe>;
	Fri, 13 Jul 2001 07:11:34 -0400
Message-ID: <3B4ED7C4.D121CF5F@gmx.at>
Date: Fri, 13 Jul 2001 13:13:08 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kenneth Vestergaard Schmidt <charon@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
In-Reply-To: <20010712215357.91B6DB6357@binary.dyndns.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Vestergaard Schmidt wrote:
> 
> Thomas Foerster wrote:
> > Seems to be the problem with the AMD optimazion in the kernel.
> 
> Funny, I have only had one minor problem with my setup. It's the same
> processor, only with one 512 meg PC133 block, and the ASUS A7V133
> motherboard (which is equipped with the same chipset). My videocard is also
> the same (ASUS V-7700), but my PSU is only 300Mhz.
> 
> The only instability I've experienced is when I was running KDM on both vt7
> and vt8, and then logging out from X. Sometimes (entirely random) it would
> freeze solid (something like once a week). I've had this setup since 2.4.1,
> and the kernel has always been compiled with Athlon optimizations, and with
> VIA 82CXXX chipset support.

I am wondering if you are using the NVidia binary driver for X. They
seem to cause some "funny" things like SIGSEGVs and random hangs. Even
without K7 optimizations.

bye,
Wilfried
