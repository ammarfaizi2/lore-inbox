Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSEaEqT>; Fri, 31 May 2002 00:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSEaEqS>; Fri, 31 May 2002 00:46:18 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:21728 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314885AbSEaEqS>;
	Fri, 31 May 2002 00:46:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Skip Ford <skip.ford@verizon.net>,
        Thunder from the hill <thunder@ngforever.de>
Subject: KBuild 2.5 Migration
Date: Fri, 31 May 2002 06:46:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020531011600.ENOZ28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net> <Pine.LNX.4.44.0205302129120.29405-100000@hawkeye.luckynet.adm> <20020531035702.EOBK28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DeIc-0007kt-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 06:01, Skip Ford wrote:
> Thunder from the hill wrote:
> > On Thu, 30 May 2002, Skip Ford wrote:
> > > I could be wrong but I think Linus wants small patches that slowly
> > > convert kbuild24 to kbuild25, and not just a chopped up wholesale
> > > kbuild25.
> > 
> > That's what we have. If you want to try kbuild-2.5, you have to use the
> > Makefile-2.5 explicitly. If you don't explicitly do that, you're using 
> > kbuild-2.4, so you got a pretty good chance to evaluate kbuild-2.5 and 
> > then decide whether you leave it or pull it. Enough migration?
> 
> That's not a migration at all.  That's two different build systems side
> by side.
> 
> A migration would mean that there is only ever 1 build system.  Send
> patches that would convert what we have now to kbuild25 over the next 10
> kernel releases or so.  That's a migration.

You're 'improving' the meaning of the term a little.  Suppose you're
going to migrate all the servers in a company from Windows to Linux, do
you come up with a succesion of intermediate operating systems?  IOW, in
a migration, it is the users who migrate, not the software.  I believe
the term you were thinking of is 'evolution'.

-- 
Daniel
