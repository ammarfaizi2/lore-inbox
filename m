Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSHGQUw>; Wed, 7 Aug 2002 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318402AbSHGQUw>; Wed, 7 Aug 2002 12:20:52 -0400
Received: from pat.uio.no ([129.240.130.16]:10447 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318383AbSHGQUv>;
	Wed, 7 Aug 2002 12:20:51 -0400
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
References: <EE83E551E08D1D43AD52D50B9F511092E114DE@ntserver2>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Aug 2002 18:24:23 +0200
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114DE@ntserver2>
Message-ID: <shs65ymd4co.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

     > Hi, I wonder if someone knows why files open with O_SYNC option
     > on an NFS mounted drive don't get synchronized? Is it an open
     > issue?  The directory is both exported and mounted using sync
     > option.

You'll have to ask RedHat. 2.4.18-3 is *not* a stock Linux kernel.

Cheers,
  Trond
