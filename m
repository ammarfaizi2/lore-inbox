Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSEUT4b>; Tue, 21 May 2002 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSEUT4a>; Tue, 21 May 2002 15:56:30 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:646 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S316577AbSEUT4a>;
	Tue, 21 May 2002 15:56:30 -0400
Date: Tue, 21 May 2002 15:56:31 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Kevin Buhr <buhr@telus.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lazy Newbie Question
In-Reply-To: <87ptzpwdvd.fsf@saurus.asaurus.invalid>
Message-ID: <Pine.LNX.4.33L2.0205211556040.16426-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2002, Kevin Buhr wrote:

> "Calin A. Culianu" <calin@ajvar.org> writes:
> >
> > int kcomedilib_main.c: comedi_t * comedi_open(const char *pathname).
>
> Which version of Comedi are you using?  In comedi-0.7.64 (the most
> recent that I can find), I see:
>
>   comedi-0.7.64/comedi/kcomedilib/kcomedilib_main.c:
>         int comedi_open(unsigned int minor)

Get comedi-cvs.

>
> In comedilib-0.7.18, I see:
>
>   comedilib-0.7.18/include/comedilib.h:
>         comedi_t *comedi_open(const char *fn);
>
> but of course that version is meant to be called from user space.
>
> I can't find the string "pathname" in any Comedi code anywhere.
>
> > 'nuff said.
>
> On the contrary...

Yeah whatever.

>
>

