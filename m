Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284191AbRLWX04>; Sun, 23 Dec 2001 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284220AbRLWX0p>; Sun, 23 Dec 2001 18:26:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:36269
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284191AbRLWX0i>; Sun, 23 Dec 2001 18:26:38 -0500
Date: Sun, 23 Dec 2001 18:12:40 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Cameron Simpson <cs@zip.com.au>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011223181240.A25679@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Cameron Simpson <cs@zip.com.au>,
	David Garfield <garfield@irving.iisd.sra.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011224100032.A17985@zapff.research.canon.com.au> <Pine.LNX.4.33L.0112232108470.12081-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112232108470.12081-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Dec 23, 2001 at 09:10:35PM -0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>:
> It doesn't help anything if there are more precise
> terms when they're used inconsistently. Somebody will
> have to check and fix this, continuously.

The situation is not as bad as you think, Rik.  I grepped; the Documentation
subtree only has 17 instances of KB, of which about 6 clearly don't need
correcting as they really are referring to disk capacities.  The patch to
fix these references would not be large.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

...Virtually never are murderers the ordinary, law-abiding people
against whom gun bans are aimed.  Almost without exception, murderers
are extreme aberrants with lifelong histories of crime, substance
abuse, psychopathology, mental retardation and/or irrational violence
against those around them, as well as other hazardous behavior, e.g.,
automobile and gun accidents."
        -- Don B. Kates, writing on statistical patterns in gun crime
