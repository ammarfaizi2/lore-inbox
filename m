Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRGJOhM>; Tue, 10 Jul 2001 10:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266465AbRGJOhC>; Tue, 10 Jul 2001 10:37:02 -0400
Received: from weta.f00f.org ([203.167.249.89]:42626 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266448AbRGJOgn>;
	Tue, 10 Jul 2001 10:36:43 -0400
Date: Wed, 11 Jul 2001 02:36:36 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010711023636.E31966@weta.f00f.org>
In-Reply-To: <20010710161943.A7785@caldera.de> <20010711022509.C31966@weta.f00f.org> <20010710163243.A8818@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710163243.A8818@caldera.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 04:32:43PM +0200, Christoph Hellwig wrote:

    The largest Chipset I know about are the 8 Way ones.
    (What is SE?).

A moronic attempt as using this funny qwerty layout thing.  It should
read SW (ServerWorks).

    They must be the Unisys OEM machines.  They are based on some
    crossbar-architecture called CMP that allows logical partioning,
    etc..

Yup, turns out they are.

    I have talked to Unisys engineers on last Cebit who said that the
    NT (now W2k) port required a huge amount of work.  Also I noticed
    that UnixWare^H^H^H^H^HOpenUnix needed work to run on it.

Well, I guess NetBSD is a good candidate, it has a nice portable MM
system, linux might not be so bad either, but without knowledge of how
this works, I am just guessing and probably still talking shit.



  --cw
