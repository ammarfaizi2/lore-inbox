Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284677AbRLPPkC>; Sun, 16 Dec 2001 10:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284674AbRLPPjx>; Sun, 16 Dec 2001 10:39:53 -0500
Received: from mons.uio.no ([129.240.130.14]:6905 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284659AbRLPPjh>;
	Sun, 16 Dec 2001 10:39:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15388.49199.506238.303762@charged.uio.no>
Date: Sun, 16 Dec 2001 16:39:27 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112161625200.876-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112161557070.876-100000@Appserv.suse.de>
	<Pine.LNX.4.33.0112161625200.876-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > Yup, it's still there with 2.4.17-rc1 as the client too.  Exact
     > same failure.

I get a size error when I don't apply the patch that fixes the
attribute update race. Can you try with that patch applied? It
can be found on

  http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif

Cheers,
  Trond
