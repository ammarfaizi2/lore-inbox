Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278022AbRJIW1f>; Tue, 9 Oct 2001 18:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278025AbRJIW1P>; Tue, 9 Oct 2001 18:27:15 -0400
Received: from [213.97.184.209] ([213.97.184.209]:640 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S278024AbRJIW1H>;
	Tue, 9 Oct 2001 18:27:07 -0400
Date: Wed, 10 Oct 2001 00:27:31 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Charles Cazabon <linux-kernel@discworld.dyndns.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
In-Reply-To: <20011009161737.A14175@qcc.sk.ca>
Message-ID: <Pine.LNX.4.33.0110100021480.446-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Charles Cazabon wrote:

> Robert Love <rml@tech9.net> wrote:
> >
> > It seems that any Athlon (even Durons) work fine in SMP configurations.
>
> They work, but not "fine".  There are performance issues with
> Thunderbird-core Athlons in SMP configurations that may slow them down
> somewhat.

	What kind of performance slow down? I have two Thunderbird 1.4Ghz
on an Tyan Tiger MP and they are quite fast (that is what I call
totally-subjective-and-no-value-at-all benchmark :-)

> > I have heard conflicting reports of what is actually different about the
> > MP vs non-MP parts, with points ranging from "the MP parts are just
> > certified" to that MP actually has some different internals.  Whatever
> > the case, I suppose the difference isn't earth-shattering and mostly
> > marketing (ala Intel).

	I've hear about some problems with the ALU Integer operation,
mainly reported by SiSoft Sandra SMP tests, (look at the Tyan forum
in www.amdmb.com), but at the end it seems that both the Thunderbird and
the Palomino have the same problem.

	I would like to benchmark the ALU Integer operation in SMP under
linux, maybe after all the low scores are due to a low quality OS :-)
Do you know about any "standard" benchmark that run in linux and stress
SMP ALU Integer operation?

> Non-MP Athlons to now have all been Thunderbird (or earlier) cores.  MP
> Athlons are Palomino cores.  The new Athlon XP is a Palomino core.  The
> Palomino has specific fixes for MP operation (no more slowdowns due to
> SMP), and various performance improvements.

	I bought the Thunderbird because they cost half the money than
the MP, and mainly because of availability (uhmm, not sure about this
word), here in Spain few people knows about MP Athlon, and even fewer
could get their hands on them.

	Regards,

	- german


-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

