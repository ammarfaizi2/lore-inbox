Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRLFR7E>; Thu, 6 Dec 2001 12:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281754AbRLFR6z>; Thu, 6 Dec 2001 12:58:55 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:41659 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281726AbRLFR6j>; Thu, 6 Dec 2001 12:58:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Thu, 6 Dec 2001 04:57:17 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Eric S. Raymond" <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33L.0112061447560.1282-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0112061447560.1282-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206175837.IRKQ15590.femail45.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 December 2001 11:49 am, Rik van Riel wrote:

> > It's insidious, isn't it?
>
> Yes, I agree the method you're using to smuggle CML2 into
> a stable kernel is insidious. Please stop it.

1) I'm not.  You're getting your players confused.

2) I don't think Marcelo would take it, so I wouldn't even bother offering it 
to him.

3) I'm suggesting that if it does go in the old method doesn't go away, so 
that people who don't want to use the new stuff don't have to.  I think 
making the old pile of cruft disappear in a stable series IS a bad thing.  
However, if adding new modular subsystems which people don't have to use (and 
which require newer tools if you DO want to use them) was a bad thing...  
Reiser, ext3, and the new vm circa 2.4.10 broke several GUI system monitors...

> regards,
>
> Rik

Rob
