Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTBTQ5d>; Thu, 20 Feb 2003 11:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBTQ5d>; Thu, 20 Feb 2003 11:57:33 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:62363 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266038AbTBTQ5c>; Thu, 20 Feb 2003 11:57:32 -0500
Date: Thu, 20 Feb 2003 17:07:37 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@quaratino
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 amd speculative caching
Message-ID: <Pine.GSO.4.50.0302201704570.3443-100000@quaratino>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> According to Richard Brunner of AMD's email to the list dated June 11,
> 2002, the cache attribute bug only affected Athlon XPs and MPs, so
> that can't be the problem here, can it?

I think it can - I believe Durons > 1GHz use the "Palomino" core (just
with less cache), so they would have the same issues as the Athlon XP.
Earlier Durons used the "Thunderbird" core if I remember rightly.

Cheers
Alastair
