Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSFBOjc>; Sun, 2 Jun 2002 10:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSFBOjb>; Sun, 2 Jun 2002 10:39:31 -0400
Received: from dsl-213-023-038-078.arcor-ip.net ([213.23.38.78]:50068 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317191AbSFBOjb>;
	Sun, 2 Jun 2002 10:39:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sam Ravnborg <sam@ravnborg.org>,
        Thunder from the hill <thunder@ngforever.de>
Subject: Re: KBuild 2.5 Impressions
Date: Sun, 2 Jun 2002 16:38:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu> <Pine.LNX.4.44.0206020139510.29405-100000@hawkeye.luckynet.adm> <20020602160357.A1726@mars.ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17EWV7-0000Pv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 June 2002 16:03, Sam Ravnborg wrote:
> On Sun, Jun 02, 2002 at 01:58:10AM -0600, Thunder from the hill wrote:
> [cc: list trimmed]
> 
> > I split it so that you can merge some stuff in and it has no effect. You 
> > can even merge the whole thing in with no effect as long as you're using 
> > the old Makefile,v 2.4.
> 
> Piecemal is not about splitting the patch in small bits only.
> It's about adding features one-by-one, and about fixing bugs one-by-one.

You mean, fixing the bugs you introduced by trying to add it piecemeal?
How about breaking it up where it makes sense to do so, and not breaking
it up where it's silly.

If you have a specific suggestion about which part should be broken out,
feel free to provide details.

-- 
Daniel
