Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSD3LqP>; Tue, 30 Apr 2002 07:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313258AbSD3LqO>; Tue, 30 Apr 2002 07:46:14 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:58243 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S313254AbSD3LqO> convert rfc822-to-8bit; Tue, 30 Apr 2002 07:46:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Frank Schaefer <frank.schafer@setuza.cz>, linux-kernel@vger.kernel.org
Subject: Re: What compiler to use
Date: Tue, 30 Apr 2002 20:43:24 +0900
X-Mailer: KMail [version 1.4]
In-Reply-To: <1020166388.417.9.camel@ADMIN>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204302043.24504.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 April 2002 20:33, Frank Schaefer wrote:
> I plan to build a linux box for kernel development (only). Which
> compiler would you suggest me to use?
> As of today I'm using gcc-2.95.3 on all my production machines. Is this
> still the preferred compiler for kernel work, or should I change to
> 3.0.x?

I use 2.95.2 for the test machine and gcc-3.1 from cvs on the other. There's 
no problem.
gcc-3.1 gives a bit more warning. (I use 3.1 at home also)
but don't try to use gcc 3.2 because the kernel won't compile in some cases.

Gabor

