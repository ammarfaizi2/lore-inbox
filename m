Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRK1T1J>; Wed, 28 Nov 2001 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRK1T1A>; Wed, 28 Nov 2001 14:27:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39436 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280084AbRK1T0u>; Wed, 28 Nov 2001 14:26:50 -0500
Date: Wed, 28 Nov 2001 16:09:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C043468.D50998E@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111281609270.15571-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Nov 2001, Andrew Morton wrote:

> Torrey Hoffman wrote:
> > 
> > I've running 2.4.16 with this VM patch combined with your
> > 2.4.15-pre7-low-latency patch from www.zip.com.au.  (it applied with a
> > little fuzz, no rejects). Is this a combination that you would feel
> > comfortable with?
> 
> Should be OK.  There is a possibility of livelock when you have
> a lot of dirty buffers against multiple devices.

Could you please describe this one ?

