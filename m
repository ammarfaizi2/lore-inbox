Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271805AbRHRKY5>; Sat, 18 Aug 2001 06:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRHRKYr>; Sat, 18 Aug 2001 06:24:47 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:31183 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271805AbRHRKYe>; Sat, 18 Aug 2001 06:24:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: ebiederm@xmission.com (Eric W. Biederman), Dan Hollis <goemon@anime.net>
Subject: Re: Encrypted Swap
Date: Sat, 18 Aug 2001 03:24:28 -0700
X-Mailer: KMail [version 1.2]
Cc: <root@chaos.analogic.com>,
        David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108171200510.4065-100000@anime.net> <m1snepoft6.fsf@frodo.biederman.org>
In-Reply-To: <m1snepoft6.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <01081803242800.00266@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 August 2001 02:52 am, Eric W. Biederman wrote:
> Dan Hollis <goemon@anime.net> writes:
> > On 17 Aug 2001, Eric W. Biederman wrote:
> > > Clearing memory on most machines takes a 1s or less.  Think of
> > > memory fill rates at the 800MB/s level.  Most BIOS's seem to clear
> > > some of the memory but I haven't read their code to see what they
> > > are doing.
> >
> > Ive measured rates far lower than that, at least for SDRAM.
>
> Hmm.  The numbers were off the top of my head and I've been messing
> with DDR SDRAM quite a bit so I may have doubled it.   Hmm.
>
> Nope.  I was remember something close to the typical streams numbers
> on an Athlon with DDR SDRAM.  Since those are read-modify-write
> numbers they should be close to the write numbers for normal SDRAM.
>
> With a PII/PIII and PC100 SDRAM I have measured about 640 MB/s writes.
>

I'm not sure where you're pulling these numbers from, but being a 
hardcore FPS gamer, I can tell you from experience, PC100 SDRAM does NOT 
hit 640MB/sec! Esspecialy not on a PII! PC100 SDRAM on my current 800Mhz 
non-tbird Athlon currently peaks near 250MB/sec
