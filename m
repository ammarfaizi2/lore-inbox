Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSD3MKl>; Tue, 30 Apr 2002 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313265AbSD3MKk>; Tue, 30 Apr 2002 08:10:40 -0400
Received: from violet.setuza.cz ([194.149.118.97]:9995 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313264AbSD3MKj>;
	Tue, 30 Apr 2002 08:10:39 -0400
Subject: Re: What compiler to use
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200204302043.24504.wom@tateyama.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 30 Apr 2002 14:10:35 +0200
Message-Id: <1020168635.419.11.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-30 at 13:43, Gabor Kerenyi wrote:
> On Tuesday 30 April 2002 20:33, Frank Schaefer wrote:
> > I plan to build a linux box for kernel development (only). Which
> > compiler would you suggest me to use?
> > As of today I'm using gcc-2.95.3 on all my production machines. Is this
> > still the preferred compiler for kernel work, or should I change to
> > 3.0.x?
> 
> I use 2.95.2 for the test machine and gcc-3.1 from cvs on the other. There's 
> no problem.
> gcc-3.1 gives a bit more warning. (I use 3.1 at home also)
> but don't try to use gcc 3.2 because the kernel won't compile in some cases.
> 
> Gabor
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Thanks
Frank

