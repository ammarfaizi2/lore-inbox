Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLPPvC>; Sun, 16 Dec 2001 10:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbRLPPuw>; Sun, 16 Dec 2001 10:50:52 -0500
Received: from pat.uio.no ([129.240.130.16]:17394 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S284669AbRLPPuk>;
	Sun, 16 Dec 2001 10:50:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15388.49868.40227.838737@charged.uio.no>
Date: Sun, 16 Dec 2001 16:50:36 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112161646210.876-100000@Appserv.suse.de>
In-Reply-To: <15388.49199.506238.303762@charged.uio.no>
	<Pine.LNX.4.33.0112161646210.876-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Sun, 16 Dec 2001, Trond Myklebust wrote:
    >> I get a size error when I don't apply the patch that fixes the
    >> attribute update race. Can you try with that patch applied? It
    >> can be found on
    >> http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif

     > No change with this applied on client side. Should I bother
     > recompiling server side with this ?

Nope. It is client-only...

Cheers,
  Trond
