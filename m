Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSFCCsc>; Sun, 2 Jun 2002 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSFCCsb>; Sun, 2 Jun 2002 22:48:31 -0400
Received: from relay1.pair.com ([209.68.1.20]:44296 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317258AbSFCCsb>;
	Sun, 2 Jun 2002 22:48:31 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CFAD94B.F848897B@kegel.com>
Date: Sun, 02 Jun 2002 19:49:47 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: KBuild 2.5 Impressions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Well, actually a lot of the work done by Kai is simply importing
> portions of Keith's work that break out easily, which is purely
> duplication of effort, since such work is already in progress.  In
> fact it creates more work, because then we have to go parse Kai's
> patches and find out what he submitted, then see if it gets applied
> so we can mark it 'applied' in the list.  This is a real waste of
> time, and did I mention, it's divisive?

Linus sees Kai as being the most promising fellow to
integrate kbuild2.5 right now (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=102307114005894&w=2 )
and Kai is willing to take it on in just the way Linus wants.
It's probably worth giving Kai and Linus the benefit of the doubt for a while,
even if it does mean having to rejigger the kbuild-2.5 patch
each time Linux accepts one of Kai's patches.

I personally am anxious to see kbuild-2.5 make it into the kernel,
but I also feel it can only benefit from a strong review of
the sort that comes about during gradual evolution
of the kernel build process towards the techniques used by kbuild-2.5.

Thanks to everyone, Keith, Daniel, Thunder, and Kai, who are
working (together or not!) on moving the kernel build process
into the modern era.
- Dan
