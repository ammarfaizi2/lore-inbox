Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290233AbSAOSbH>; Tue, 15 Jan 2002 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290234AbSAOSa6>; Tue, 15 Jan 2002 13:30:58 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:55817 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290233AbSAOSao>; Tue, 15 Jan 2002 13:30:44 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.33597.541416.111554@laputa.namesys.com>
Date: Tue, 15 Jan 2002 22:30:05 +0300
To: "David L. Parsley" <parsley@roanoke.edu>
Cc: Hans-Peter Jansen <hpj@urpla.net>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <3C446E6B.1020709@roanoke.edu>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<E16QVf3-0002NG-00@charged.uio.no>
	<15428.23828.941425.774587@laputa.namesys.com>
	<20020115163208.785831435@shrek.lisa.de>
	<15428.27801.724105.557093@laputa.namesys.com>
	<3C446E6B.1020709@roanoke.edu>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David L. Parsley writes:
 > Nikita,
 > 
 > To be clear: if I upgrade the kernel on my nfs server to 2.4.latest and 
 > mount -o conv my reiserfs partition, that will almost certain fix my 
 > knfsd problem with a very small likelihood of generation problems?

It will make likelihood smaller than before. As to whether it will be
sufficiently small for your purposes I can not make any claims. I
recommend you to upgrade to 3.6.

 > 
 > regards,
 > 	David

Nikita.

 > -- 
 > David L. Parsley
 > Network Administrator, Roanoke College
 > "If I have seen further it is by standing on ye shoulders of Giants."
 > --Isaac Newton
 > 
 > 
