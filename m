Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHLK6m>; Mon, 12 Aug 2002 06:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHLK6l>; Mon, 12 Aug 2002 06:58:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:43793 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317858AbSHLK6l>; Mon, 12 Aug 2002 06:58:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Vitaly Fertman <vitaly@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: reiserfsprogs release
Date: Mon, 12 Aug 2002 15:00:23 +0400
X-Mailer: KMail [version 1.4]
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
References: <200206251829.25799.vitaly@namesys.com> <200208121442.19656.vitaly@namesys.com> <1029154185.16421.161.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029154185.16421.161.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208121500.23626.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-08-12 at 11:42, Vitaly Fertman wrote:
> > Hi all,
> >
> > a critical bug was fixed in reiserfsck journal replay process,
> > so we decided to release a new 3.6.3 progs with just 2 bug
> > fixes related to it.
>
> What version does reiserfsck in this report. That way I can update

All utilities have the same version as the package has, so 3.6.3.

> CHANGES to indicate the 3.6.3 bits are required.
>
> Right now it says 3.x.1b - should it now say 3.6.3 ?

This bug was introduced in 3.6.2, so 3.x.1b was not affected.
But 3.x.1b contains many other bugs which were fixed in 3.6.2.

-- 

Thanks,
Vitaly Fertman
