Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSFDILj>; Tue, 4 Jun 2002 04:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSFDILi>; Tue, 4 Jun 2002 04:11:38 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:63380 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S316541AbSFDILi>;
	Tue, 4 Jun 2002 04:11:38 -0400
Date: Tue, 4 Jun 2002 01:11:37 -0700 (PDT)
From: J Sloan <jjs@mirai.cx>
To: Rik van Riel <riel@conectiva.com.br>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Larry McVoy <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please kindly get back to me
In-Reply-To: <Pine.LNX.4.44L.0206040406510.24135-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0206040111170.29920-100000@neo.mirai.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah - but how many messages/month?

Joe

On Tue, 4 Jun 2002, Rik van Riel wrote:

> On Mon, 3 Jun 2002, Matti Aarnio wrote:
> 
> >   Best technologies (as I see them, but I am not omniscient, of course)
> >   are those that do scoring.  E.g. naving some word NN might not alone
> 
> >   I think there are several free codes of this kind available, but my time
> >   has been chronically over-subscribed to do radical things like taking
> >   this kind of codes into use.
> 
> 1) mv resend resend.mj
> 
> 2) use this script as resend
> 
> --------------
> #!/bin/sh
> 
> /path/to/spamassassin -L | /path/to/resend.mj $*
> --------------
> 
> 3) add X-Spam-Flag:.*YES to taboo_headers
> 
> I'm doing this for the listar setup on nl.linux.org and things
> work great. Only took 10 minutes to install, too.
> 
> Rik
> 

