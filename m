Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHGWQK>; Wed, 7 Aug 2002 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHGWQK>; Wed, 7 Aug 2002 18:16:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12553 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313711AbSHGWQJ>; Wed, 7 Aug 2002 18:16:09 -0400
Date: Wed, 7 Aug 2002 19:19:21 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org, <jmacd@namesys.com>, <phillips@arcor.de>,
       <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020807221532.GA20469@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208071918440.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Jesse Barnes wrote:
> On Wed, Aug 07, 2002 at 06:21:07PM -0300, Rik van Riel wrote:
> > On Wed, 7 Aug 2002, Jesse Barnes wrote:
> > > macro worked before?  I could just remove all those checks in the scsi
> > > code I guess.
> >
> > That would be a better option.
>
> Does this look a little better?  Thanks for checking it out.

Looks good to me. Would be even better if you removed MUST_NOT_HOLD ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

