Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSHCVB4>; Sat, 3 Aug 2002 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSHCVB4>; Sat, 3 Aug 2002 17:01:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9205 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317778AbSHCVBz>; Sat, 3 Aug 2002 17:01:55 -0400
Subject: Re: Linux v2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ged Haywood <ged@www2.jubileegroup.co.uk>
Cc: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0208032156330.29654-100000@www2.jubileegroup.co.uk>
References: <Pine.LNX.4.21.0208032156330.29654-100000@www2.jubileegroup.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 23:23:25 +0100
Message-Id: <1028413405.1761.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 22:00, Ged Haywood wrote:
> Hi there,
> 
> On Sat, 3 Aug 2002, Mr. James W. Laferriere wrote:
> 
> > Haven't the tarballs usuaully been archived as 'linux/' instead of
> > 'linux-2.4.19/' ?
> 
> Absolutely not.  Many systems have a symlink 'linux' to the current
> kernel tree, which is a directory e.g. 'linux-2.2.16'.  If the tarball

Kernels until recently did always unpack into linux/. Linus changed and
I'm happy Marcelo has followed suit, its much more sensible the new way

