Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRCFV2s>; Tue, 6 Mar 2001 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRCFV2c>; Tue, 6 Mar 2001 16:28:32 -0500
Received: from anime.net ([63.172.78.150]:26634 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129517AbRCFV2T>;
	Tue, 6 Mar 2001 16:28:19 -0500
Date: Tue, 6 Mar 2001 13:29:25 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Mordechai Ovits <movits@ovits.net>
cc: Hao Sun <hsun@mtgbcs.usae.avaya.com>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP vegas implementation
In-Reply-To: <20010306162038.A28153@ovits.net>
Message-ID: <Pine.LNX.4.30.0103061328260.21276-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Mordechai Ovits wrote:
> On Tue, Mar 06, 2001 at 12:03:02PM -0500, Hao Sun wrote:
> > > From Neal Cardwell (cardwell@cs.washington.edu)
> > > Tue, 20 Jul 1999 03:08:21 -0700 (PDT)
> > > A new TCP Vegas patch for 2.2.10/2.3.10 is available at:
> > > http://www.cs.washington.edu/homes/cardwell/linux-vegas/
> > Does anyone know where to get the above TCP vegas implementation code
> > or a more recent one? The link above is broken and Neal Cardwell is
> > not there.

I had big performance problems with tcp-vegas on highly assymetric WAN
connections (eg 8m/640k adsl). Normal tcp worked fine.

-Dan

