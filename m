Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFDOYn>; Tue, 4 Jun 2002 10:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSFDOYm>; Tue, 4 Jun 2002 10:24:42 -0400
Received: from mail.zmailer.org ([62.240.94.4]:5325 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S312560AbSFDOYl>;
	Tue, 4 Jun 2002 10:24:41 -0400
Date: Tue, 4 Jun 2002 17:24:41 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sendfile64()?
Message-ID: <20020604172441.Q18899@mea-ext.zmailer.org>
In-Reply-To: <200205311553.g4VFrP300813@mail.pronto.tv> <20020604135805.GB9641@wiget.koelner.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 03:58:06PM +0200, Artur Frysiak wrote:
> On Fri, May 31, 2002 at 05:53:23PM +0200, Roy Sigurd Karlsbakk wrote:
> > hi
> > 
> > where can i find sendfile64()? It doesn't seem to exist in any library 
> > anywhere ...
> 
> glibc from CVS ?

  It does not exist in (32 bit) kernel, mostly because it doesn't
  make much sense..    Implementing it should be trivial, once
  somebody can show real meaningfull use for it.

> Regards
> Artur Frysiak
> http://www.pld.org.pl/

/Matti Aarnio
