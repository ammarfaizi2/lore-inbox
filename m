Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJVFbI>; Tue, 22 Oct 2002 01:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSJVFbI>; Tue, 22 Oct 2002 01:31:08 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:56900 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262198AbSJVFbH>; Tue, 22 Oct 2002 01:31:07 -0400
Date: Mon, 21 Oct 2002 22:45:32 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Nicholas Wourms <nwourms@netscape.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
In-Reply-To: <ap2bk3$b0t$1@main.gmane.org>
Message-ID: <Pine.LNX.4.44.0210212242580.23680-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Nicholas Wourms wrote:
|>Christoph Hellwig wrote:
|>
|>> On Mon, Oct 21, 2002 at 03:16:05AM -0700, Matt D. Robinson wrote:
|>>> diff -Naur linux-2.5.44.orig/drivers/dump/Makefile
|>>> linux-2.5.44.lkcd/drivers/dump/Makefile
|>>> --- linux-2.5.44.orig/drivers/dump/Makefile  Wed Dec 31 16:00:00 1969
|>>> +++ linux-2.5.44.lkcd/drivers/dump/Makefile  Sat Oct 19 12:39:15 2002
|>>> @@ -0,0 +1,30 @@
|>>> +#
|>>> +# Makefile for the dump device drivers.
|>>> +#
|>>> +# 12 June 2000, Christoph Hellwig <schch@pe.tu-clausthal.de>
|>>> +# Rewritten by Matt D. Robinson (yakker@sourceforge.net) for
|>>> +# the dump directory.
|>> 
|>> *cough* is that an old mail address and I can't even remember having
|>> touched that file.. :)  What about remoing that note..
|>> 
|>
|>Didn't this used to be an SGI project?  Perhaps that is where you might have 
|>"touched" it.

Because I used the base structure of another Makefile for making
mine, I carried over his name.

--Matt

