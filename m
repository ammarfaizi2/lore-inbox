Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284156AbRLWXEp>; Sun, 23 Dec 2001 18:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284171AbRLWXEf>; Sun, 23 Dec 2001 18:04:35 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:63642 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S284156AbRLWXEU>;
	Sun, 23 Dec 2001 18:04:20 -0500
Date: Mon, 24 Dec 2001 10:00:32 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011224100032.A17985@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011224094211.A15930@zapff.research.canon.com.au> <Pine.LNX.4.33L.0112232052360.12081-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112232052360.12081-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Dec 23, 2001 at 08:53:41PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 08:53:41PM -0200, Rik van Riel <riel@conectiva.com.br> wrote:
| On Mon, 24 Dec 2001, Cameron Simpson wrote:
| > Using KB in places where precision matters puts us all into case #4
| > below, because people think they know what KB means, but it means
| > different things to different people, and so people don't realise they
| 
| I take it this is your way of volunteering to always
| keep all kernel documentation accurate as well as
| answer questions from newbies who've never seen
| 'KiB' before ? ;)

Hmm. Not my plan at the time of typing, no.
But KB _is_ ambiguous. KiB is not (and it's ugliness is actually an advantage
here - it's less likely to be misused by people who've not seen the definition).

Just out of curiosity, is there anywhere in the kernel space where KB (et al)
is _not_ used to mean a power of 2 value?
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

When you're all dressed up and no place to go.	- B.H. Burt (19th cent)
