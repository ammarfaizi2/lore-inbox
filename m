Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHaS3w>; Fri, 31 Aug 2001 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHaS3m>; Fri, 31 Aug 2001 14:29:42 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:2732 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S268900AbRHaS3b>; Fri, 31 Aug 2001 14:29:31 -0400
Date: Fri, 31 Aug 2001 11:29:05 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010831112905.A20937@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SVC isn't the "Stanford Checker" that has been resulting in kernel
patches.  The name "Stanford Checker" was invented by people on LKML; the
real name of the project is Meta-level compilation, and its URL is:

http://hands.stanford.edu

SVC isn't a model checker either.  It's an implementation of cooperating
decision procedures.

-Andy


> > Stanford checker? Is that a programmable C type checker? If so, lemmee
> > at it. Have you a URL, btw?

> http://verify.stanford.edu/SVC/
> You should search the archive to look for some good examples, how it can
> help.

