Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSGVXVl>; Mon, 22 Jul 2002 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSGVXVl>; Mon, 22 Jul 2002 19:21:41 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:34549 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S316794AbSGVXVk>;
	Mon, 22 Jul 2002 19:21:40 -0400
Date: Tue, 23 Jul 2002 01:24:42 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile error 2.5.27: [ad1848_lib.o] Error 1
Message-ID: <20020722232442.GA1178@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020722233021.4713583a.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020722233021.4713583a.diegocg@teleline.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 22 July 2002, at 23:30:21 +0200,
Diego Calleja wrote:

> ad1848_lib.c: At top level:
> ad1848_lib.c:1181: parse error before `module_exit'
> ad1848_lib.c:1182: parse error at end of input
> make[3]: *** [ad1848_lib.o] Error 1
> make[3]: Leaving directory `/usr/src/unstable/sound/isa/ad1848'
> make[2]: *** [ad1848] Error 2
> make[2]: Leaving directory `/usr/src/unstable/sound/isa'
> make[1]: *** [isa] Error 2
> make[1]: Leaving directory `/usr/src/unstable/sound'
> make: *** [sound] Error 2
> root@diego:/usr/src/unstable#
> 
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 Fix dump non compile in ad1848 audio"

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
