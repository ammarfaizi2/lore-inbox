Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSBZXrv>; Tue, 26 Feb 2002 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSBZXrg>; Tue, 26 Feb 2002 18:47:36 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:14041 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S289366AbSBZXqm>; Tue, 26 Feb 2002 18:46:42 -0500
Message-ID: <3C7C1D3B.5050202@drugphish.ch>
Date: Wed, 27 Feb 2002 00:41:47 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2
In-Reply-To: <20020226223406.A26905@suse.de> <3C7C1AF0.3000103@drugphish.ch> <20020227003905.C9189@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Yup. All went well until ALSA arrived with its own version.h
>  Before then, I had version.h in my diff exclusion list, and everything
>  'just worked'. Oh well.. I'll add some more magic to autohch.pl[*]

Why not include it into /home/davej/.exclude?

Regarding ALSA and showing up with their own ``version.h''; what about 
the others?

o ../arch/i386/math-emu/version.h
o ../include/pcmcia/version.h
o ../include/sound/version.h

Cheers (still waiting for gcc to finish ...),
Roberto Nibali, ratz

