Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSEDQa6>; Sat, 4 May 2002 12:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSEDQa5>; Sat, 4 May 2002 12:30:57 -0400
Received: from air-2.osdl.org ([65.201.151.6]:52239 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314681AbSEDQaz>;
	Sat, 4 May 2002 12:30:55 -0400
Date: Sat, 4 May 2002 09:30:47 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
In-Reply-To: <20020504162902.GB21542@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0205040929470.22716-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, Tomas Szepe wrote:

| > | I don't know how to properly emphasize that this *is* asking for problems,
| > | but still I'd be surprised if I were the only one scared by files not
| > | connected to the build getting erased on make mrproper. Hello, anyone? :)
| >
| > Too much policy here?
| >
| > | Would it be complicated to only kill the files the build knows it had
| > | created?
| >
| > That's what I would expect.
|
|
| Word. The purpose of all the 'clean' targets in Makefiles (distclean,
| mrproper, etc.) everywhere has always been to get rid of the object/
| build files, and the object/build files only.
|
| Don't get me wrong, Keith, I believe kbuild 2.5's a terrific piece of
| code, I'm just discussing what I've found myself to be in trouble with.

Yes, I'd like to see kbuild 2.5 added to Linux 2.5 also,
but it does need some tweaking IMO.

-- 
~Randy

