Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSA0UCD>; Sun, 27 Jan 2002 15:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288544AbSA0UBx>; Sun, 27 Jan 2002 15:01:53 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:31885 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S288512AbSA0UBl>; Sun, 27 Jan 2002 15:01:41 -0500
Date: Sun, 27 Jan 2002 19:58:05 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Zealey <mark@zealos.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020127195805.G4818@kushida.apsleyroad.org>
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no> <20020126030841.C5730@kushida.apsleyroad.org> <20020126091351.GA13468@itsolve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020126091351.GA13468@itsolve.co.uk>; from mark@zealos.org on Sat, Jan 26, 2002 at 09:13:51AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Zealey wrote:
> > Just to break that rule, however, if p were a pointer and x were an
> > integer, I would write:
> > 
> >   x = (p != 0);
> 
> Heard about NULL ?

I prefer 0, thanks.  NULL has header file portability problems.

-- Jamie
