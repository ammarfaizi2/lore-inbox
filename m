Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbRLZWVZ>; Wed, 26 Dec 2001 17:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284973AbRLZWVP>; Wed, 26 Dec 2001 17:21:15 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:19205 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S284965AbRLZWU5>;
	Wed, 26 Dec 2001 17:20:57 -0500
Date: Thu, 27 Dec 2001 09:17:02 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Riley Williams <rhw@memalpha.cx>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Rik van Riel <riel@conectiva.com.br>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011227091702.A8528@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011223174608.A25335@thyrsus.com> <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX>; from rhw@memalpha.cx on Wed, Dec 26, 2001 at 05:44:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 05:44:36PM +0000, Riley Williams <rhw@memalpha.cx> wrote:
| >> I take it this is your way of volunteering to always keep all
| >> kernel documentation accurate as well as answer questions from
| >> newbies who've never seen 'KiB' before ? ;)
| 
| > One of the arguments for the KiB declaration, despite the ugliness
| > of "kibibytes", is that a newbie seeing "32KiB" is quite likely to
| > deduce what's meant from context.  Let's not exaggerate the
| > difficulties here.
| 
| Alternatively, deal with this problem the same way the "This may also be
| built as a module..." comment is - either include it several thousand
| times in Configure.help or (better still) have the configuration tools
| spit it out automatically every time the need for it crops up. The
| following ruleset could easily be implemented even in the `make config`
| and `make menuconfig` parsers, and should be just as easy in CML2.
| Applying rule (1) will result in a considerable reduction in the size of
| the file Documentation/Configure.help as it currently stands.
| 
| Comments, anybody?

I like this!
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

It was a joke, OK?  If we thought it would actually be used, we wouldn't have
written it!	- Marc Andreessen on the creation of a <blink> tag
