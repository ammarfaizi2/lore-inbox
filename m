Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272705AbRHaO3B>; Fri, 31 Aug 2001 10:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272704AbRHaO2w>; Fri, 31 Aug 2001 10:28:52 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:59152 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272703AbRHaO2l>;
	Fri, 31 Aug 2001 10:28:41 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108311428.QAA13972@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <3B8F9B48.80F513AA@linux-m68k.org> "from Roman Zippel at Aug 31,
 2001 04:12:24 pm"
To: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 31 Aug 2001 16:28:55 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roman Zippel wrote:"
> [ptb wrote]
> > Stanford checker? Is that a programmable C type checker? If so, lemmee
> > at it. Have you a URL, btw?
> 
> http://verify.stanford.edu/SVC/
> You should search the archive to look for some good examples, how it can
> help.

Hmm .. it looks like a model checker, and only for 1st order logic
(i.e. not CTL). It seems very primitive. What's the point of using this
instead of the many sphisticated model checkers and theorem provers out
there?

Peter
