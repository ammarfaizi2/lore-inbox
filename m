Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTBGSIe>; Fri, 7 Feb 2003 13:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTBGSIe>; Fri, 7 Feb 2003 13:08:34 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:58897 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S266081AbTBGSId>;
	Fri, 7 Feb 2003 13:08:33 -0500
Date: Fri, 7 Feb 2003 13:18:05 -0500
Message-Id: <200302071818.h17II5901915@gonzales.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Race in RPC code
In-Reply-To: <20030207134446.GB25807@unthought.net>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.19 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob, Trond,

On Fri, 7 Feb 2003 14:44:46 +0100, Jakob Oestergaard <jakob@unthought.net> wrote:

> The panic has happened once, just today.

I've seen this multiple times, and even reported it to the nfs mailing list.

I'm just glad someone else is seeing the same kind of oops with a vanilla 
kernel, because I was seeing it with a heavily patched 
redhat+nfs2.4.20+nfsall2.4.20 kernel and wasn't sure if that had anything
to do with it.

I have at least 5-6 such oopsen recorded, if anyone cares.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
