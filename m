Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281341AbRKTUaI>; Tue, 20 Nov 2001 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281343AbRKTU37>; Tue, 20 Nov 2001 15:29:59 -0500
Received: from mons.uio.no ([129.240.130.14]:41121 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281341AbRKTU3t>;
	Tue, 20 Nov 2001 15:29:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15354.48436.73118.74210@charged.uio.no>
Date: Tue, 20 Nov 2001 21:29:40 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux
 2.4.15pre5 client
In-Reply-To: <20011120.121828.90724455.davem@redhat.com>
In-Reply-To: <15354.45419.978323.438540@charged.uio.no>
	<200111201945.WAA03637@ms2.inr.ac.ru>
	<20011120.121828.90724455.davem@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     > Trond, Alexey is right, all the examples of sunrpc/fasync/etc.
     > are totally irrelevant.  This driver is buggy beyond belief.

Right: I wasn't trying to defend it. Rather I wanted to explain why I
believe that this particular driver deadlock is not a good enough
reason to change the current RPC code.

Cheers,
   Trond
