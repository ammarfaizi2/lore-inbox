Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSE3POT>; Thu, 30 May 2002 11:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSE3POS>; Thu, 30 May 2002 11:14:18 -0400
Received: from port-213-20-228-54.reverse.qdsl-home.de ([213.20.228.54]:13838
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S316684AbSE3POQ> convert rfc822-to-8bit; Thu, 30 May 2002 11:14:16 -0400
Date: Thu, 30 May 2002 17:13:11 +0200 (CEST)
Message-Id: <20020530.171311.607952183.rene.rebe@gmx.net>
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <3CF62F2A.6030009@evision-ventures.com>
X-Mailer: Mew version 2.2 on XEmacs 21.4.7 (Economic Science)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On: Thu, 30 May 2002 15:54:50 +0200,
    Martin Dalecki <dalecki@evision-ventures.com> wrote:

> > You still need a way to talk all the disk devices. It might be that is
> > devfs /dev/disk, but in case it hasn't permeated your skull yet, in such
> > a situation then -devfs- would need such a list. We also have another
> 
> I don't use and don't care about devfs - it's a misconception in my opinnion.
> What you are potining at is just another symptom of this simple fact.
> After several years of beeing "official" it didn't develer up on
> promises. There are some reasons why the Linux vendors out there get
> well along without it. It is simple not necessary and even worser
> introduces more problems that it promised to solve. No matter how
> vigorous the propnents of it where before Linus give in. It's just another
> try to work around the too narrow major/minor number spaces of Linux
> and well see below:

DevFS is at least used by ROCK Linux and Mandrake. We never had any
problem with it (and most users really like it's features). So please
do not corrupt it. - I save my time not lising the feature list of
devfs we use ...

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)
e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
web:      www.rocklinux.org, drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
