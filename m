Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290222AbSAOS0H>; Tue, 15 Jan 2002 13:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290233AbSAOSZ5>; Tue, 15 Jan 2002 13:25:57 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:32261 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290222AbSAOSZu>; Tue, 15 Jan 2002 13:25:50 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.33303.441511.278523@laputa.namesys.com>
Date: Tue, 15 Jan 2002 22:25:11 +0300
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <20020115181430.78CE11435@shrek.lisa.de>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<20020115163208.785831435@shrek.lisa.de>
	<15428.27801.724105.557093@laputa.namesys.com>
	<20020115181430.78CE11435@shrek.lisa.de>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen writes:
 > On Tuesday, 15. January 2002 18:53, Nikita Danilov wrote:
 > > Hans-Peter Jansen writes:
 > >  > On Tuesday, 15. January 2002 17:47, Nikita Danilov wrote:

[...]

 > 
 > If I use notail mount option on a already populated partition, what happens
 > to the "tailed" files? I expect, only newly created ones get there own block.

Right.

 > 
 > >

Nikita.

 > >
 > Cheers,
 >   Hans-Peter
 > 
