Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEUSId>; Tue, 21 May 2002 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEUSIc>; Tue, 21 May 2002 14:08:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20743 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315370AbSEUSIa>; Tue, 21 May 2002 14:08:30 -0400
Date: Tue, 21 May 2002 14:04:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dax Kelson <dax@gurulabs.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <Pine.LNX.4.44.0205202157150.24416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020521140333.1427C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Dax Kelson wrote:

> On Mon, 20 May 2002, Dax Kelson wrote:
> 
> > Example 1:
> > 
> > /home/bob/public_html
> > 
> > public_html  is user/group  bob/httpd
> > 
> > the perms are 2770
> 
> I meant 4770 since we are discussing a hypothetical SUID directory.

I would expect public_html to be 4775 or 4771 if it's to be any use at
all. Otherwise why have it?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

