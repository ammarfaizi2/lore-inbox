Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbRE1TSG>; Mon, 28 May 2001 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbRE1TR4>; Mon, 28 May 2001 15:17:56 -0400
Received: from beaker.bluetopia.net ([63.219.235.110]:25867 "EHLO
	beaker.bluetopia.net") by vger.kernel.org with ESMTP
	id <S263123AbRE1TRo>; Mon, 28 May 2001 15:17:44 -0400
Date: Mon, 28 May 2001 15:15:04 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
To: Jan Sembera <sembera@centrum.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.5] buz.c won't compile
In-Reply-To: <3B0FEB1B.5030308@centrum.cz>
Message-ID: <Pine.LNX.4.04.10105281512050.1601-100000@beaker.bluetopia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Jan Sembera wrote:
>i've got a problem compiling drivers/media/video/buz.c as module. When 
>i'm trying to compile, i get couple of errors:
...

Actually, it broke at 2.4.3.  Go look at the first change to buz.c from
that patch.

--Ricky

PS: I really hate it when people break "functional" things in the "stable"
    tree. (functional and stable are both open to debate.)

PPS: Yes, I know Linus doesn't bother compling most of the stuff :-)


