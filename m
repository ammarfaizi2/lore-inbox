Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279166AbRJaVDb>; Wed, 31 Oct 2001 16:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRJaVDL>; Wed, 31 Oct 2001 16:03:11 -0500
Received: from dsl-213-023-038-229.arcor-ip.net ([213.23.38.229]:46340 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S279228AbRJaVC6>;
	Wed, 31 Oct 2001 16:02:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Wed, 31 Oct 2001 22:04:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
        Ben Smith <ben@google.com>
In-Reply-To: <Pine.LNX.4.33L.0110311848330.2963-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0110311848330.2963-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15z2X4-0000wh-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2001 09:48 pm, Rik van Riel wrote:
> On Wed, 31 Oct 2001, Daniel Phillips wrote:
> > On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> > > I just tried your test program with 2.4.13, 2 Gig, and it ran without
> > > problems.  Could you try that over there and see if you get the same result?
> > > If it does run, the next move would be to check with 3.5 Gig.
> >
> > Ben reports that his test with 2 Gig memory runs fine, as it does for
> > me, but that it locks up tight with 3.5 Gig, requiring power cycle.
> > Since I only have 2 Gig here I can't reproduce that (yet).
> 
> Does it lock up if your low memory is reduced to 512 MB ?

Ben?

--
Daniel
