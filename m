Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272644AbRHaNa0>; Fri, 31 Aug 2001 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272683AbRHaNaQ>; Fri, 31 Aug 2001 09:30:16 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:55824 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272644AbRHaNaF>;
	Fri, 31 Aug 2001 09:30:05 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108311329.PAA12559@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0108311433070.24580-100000@serv> "from Roman Zippel
 at Aug 31, 2001 02:58:21 pm"
To: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 31 Aug 2001 15:29:41 +0200 (CEST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roman Zippel wrote:"
> On Fri, 31 Aug 2001, Peter T. Breuer wrote:
> > Try reading the last 10 days kernel messages. The last 48 hours are
> > particularly rewarding.
> 
> I have, but I only get the feeling, we're hunting here for imaginary bugs.

As I said, nobody has been too precise about the bugs to me either! I
just want to provide an alternative to the 3arg min/max that would
otherwise have been imposed. Whether we really need either of these
alternatives is another argument.

> Real bugs could be found with -Wsign-compare, but nobody wants to use it
> because our master doesn't want it...
> Please define the bugs first, you're trying to fix! If you don't like
> -Wsign-compare, consider defining rules for the Stanford checker. This way

Stanford checker? Is that a programmable C type checker? If so, lemmee
at it. Have you a URL, btw?

Peter
