Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSEDQUG>; Sat, 4 May 2002 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314556AbSEDQUF>; Sat, 4 May 2002 12:20:05 -0400
Received: from air-2.osdl.org ([65.201.151.6]:51725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314502AbSEDQUF>;
	Sat, 4 May 2002 12:20:05 -0400
Date: Sat, 4 May 2002 09:19:51 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: tomas szepe <kala@pinerecords.com>
cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
In-Reply-To: <20020504121529.GA20335@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0205040918450.22716-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, tomas szepe wrote:

| Hmm, I don't think this analogy will do -- working with aliases involving
| fileutils as root is a way straight to hell, and hardly anyone ever walks
| it. With kbuild-2.5, however, I have to set $KBUILD_OBJTREE every time
| I want to build a kernel with objects out of the source dir -- and hey,
| is there a single person on this list who's never made a typo on the
| command line?
|
| I don't know how to properly emphasize that this *is* asking for problems,
| but still I'd be surprised if I were the only one scared by files not
| connected to the build getting erased on make mrproper. Hello, anyone? :)

Too much policy here?

| Would it be complicated to only kill the files the build knows it had
| created?

That's what I would expect.

-- 
~Randy

