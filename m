Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHYPnk>; Sat, 25 Aug 2001 11:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbRHYPnb>; Sat, 25 Aug 2001 11:43:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:267 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269428AbRHYPnS>; Sat, 25 Aug 2001 11:43:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 17:49:13 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108242231480.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108242231480.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825154325Z16125-32383+1325@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 03:34 am, Rik van Riel wrote:
> On Sat, 25 Aug 2001, Daniel Phillips wrote:
> > My point is, even with the case you supplied the expected behaviour of
> > the existing algorithm is acceptable.  There is no burning fire to put
> > out, not here anyway.
> 
> True, it's just an issue of performance and heavily used
> servers falling over under load, nothing as serious as
> data corruption or system instability.

If your server is falling over under load, this is not the reason.

--
Daniel
