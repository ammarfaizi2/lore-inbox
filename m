Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSD3NNr>; Tue, 30 Apr 2002 09:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313504AbSD3NNq>; Tue, 30 Apr 2002 09:13:46 -0400
Received: from mustard.heime.net ([194.234.65.222]:27080 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S313492AbSD3NNq>; Tue, 30 Apr 2002 09:13:46 -0400
Date: Tue, 30 Apr 2002 15:11:13 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Gabor Kerenyi <wom@tateyama.hu>
cc: Frank Schaefer <frank.schafer@setuza.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: What compiler to use
In-Reply-To: <200204302043.24504.wom@tateyama.hu>
Message-ID: <Pine.LNX.4.44.0204301508100.1644-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, Gabor Kerenyi wrote:

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

Is this common knowledge? Is 3.1 as stable as 2.95.[23] for compiling the 
kernel? Does it make any difference in performace?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


