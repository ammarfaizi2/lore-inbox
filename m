Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283672AbRLWWmy>; Sun, 23 Dec 2001 17:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282805AbRLWWmo>; Sun, 23 Dec 2001 17:42:44 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:20026 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S282492AbRLWWm1>;
	Sun, 23 Dec 2001 17:42:27 -0500
Date: Mon, 24 Dec 2001 09:42:11 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011224094211.A15930@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011221134034.B11147@thyrsus.com> <Pine.LNX.4.33L.0112211913360.28489-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112211913360.28489-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Dec 21, 2001 at 07:17:45PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 07:17:45PM -0200, Rik van Riel <riel@conectiva.com.br> wrote:
| On Fri, 21 Dec 2001, Eric S. Raymond wrote:
| > What, and *encourage* non-uniform terminology?  No, I won't do that.
| > Better to have a single standard set of abbreviations, no matter how
| > ugly, than this.
| 
| Last I checked the purpose of language was _communication_.
| Better use words people understand.

Well, what we have is KB, which people _think_ they understand, but do not.
And KiB, which is ugly but well defined, albeit less known (at present).

| Also, the kB vs KiB mess is so ambiguous and complex that
| it virtually guarantees that the _writers_ of documentation
| will get it wrong occasionally and only confuse the readers
| more.

KiB is not ambiguous. KB demonstrably is.
And therefore KB is NOT useful for communication, _especially_ technical
communication.

| As a last point, we shouldn't forget about the inconsistent
| way in which the marketing departments of hardware vendors
| apply these units to their products. In many cases binary
| and decimal units are mixed, leading to something which is
| impossible to "get right".  Disk space would be one example
| of this, but I'm sure there are more.

You're just making the case for KB weaker you know...

For all that KiB is ugly, at least it is not ambiguous.
I'll take "precise" over "vague" in technical documentation any time.

Using KB in places where precision matters puts us all into case #4 below,
because people think they know what KB means, but it means different
things to different people, and so people don't realise they are using
a vague term. Which is very bad.
--
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Men are four:
    He who knows and knows that he knows; he is wise, follow him.
    He who knows and knows not that he knows; he is asleep, wake him.
    He who knows not and knows that he knows not; he is ignorant, teach him.
    He who knows not and knows not that he knows not; he is a fool, spurn him!
