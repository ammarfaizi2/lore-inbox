Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSJNNiP>; Mon, 14 Oct 2002 09:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJNNiO>; Mon, 14 Oct 2002 09:38:14 -0400
Received: from mons.uio.no ([129.240.130.14]:50344 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261622AbSJNNiO>;
	Mon, 14 Oct 2002 09:38:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15786.51719.778824.642700@charged.uio.no>
Date: Mon, 14 Oct 2002 15:43:35 +0200
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
In-Reply-To: <20021014045410.4721c209.skraw@ithnet.com>
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > Trond Myklebust <trond.myklebust@fys.uio.no>:
     > o Workaround NFS hangs introduced in 2.4.20-pre

That's an NFS *client* change. It doesn't touch any of the server
code.

Cheers,
  Trond
