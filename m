Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHTIAa>; Tue, 20 Aug 2002 04:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSHTIAa>; Tue, 20 Aug 2002 04:00:30 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14085
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316582AbSHTIA2>; Tue, 20 Aug 2002 04:00:28 -0400
Date: Tue, 20 Aug 2002 01:04:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: IDE-DGD update.
In-Reply-To: <6uznvirmxg.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.10.10208200055560.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Sean Neakums wrote:

> commence  Thunder from the hill quotation:
> 
> > Hi,
> >
> > On Fri, 16 Aug 2002, Linus Torvalds wrote:
> >>  - phase 2: IDE-TNG.
> >
> > Couldn't we give it another name? Such as LUI - Linux Unified IDE? 
> > Whatever? TNG is too much mainstream and sounds just too clumsy...
> 
> Call it IDE-DS9, then.

Call it anything, I do not care.
However you should because, I will guarentee it works in closed form.
It may be stick ugly coding, but you can bet your data it will be just
where you put it when you want it back.

With the saving grace of Alan Cox and company it will be kernel correct
and maybe pleasing to read if you want, and you can still bet your data it
will be just where you put it when you want it back.

If you want a preview of clean up and broad sweeping design rework.

2.4.20-pre2-ac5 and in less than 24hours hopefully ac6.

We will be bringing to the table, hot-plugable HBA.
This will include fully modular HOST controllers.
The short side is we are restricting unloading of controllers for now.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

