Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTBGTlv>; Fri, 7 Feb 2003 14:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTBGTlv>; Fri, 7 Feb 2003 14:41:51 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:37030 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266717AbTBGTlt>; Fri, 7 Feb 2003 14:41:49 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Ion Badulescu <ionut@badula.org>, Jakob Oestergaard <jakob@unthought.net>
Subject: Re: Race in RPC code
Date: Fri, 7 Feb 2003 20:51:08 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
References: <200302071818.h17II5901915@gonzales.badula.org>
In-Reply-To: <200302071818.h17II5901915@gonzales.badula.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302072051.08643.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 February 2003 19:18, Ion Badulescu wrote:
> Hi Jakob, Trond,
>
> On Fri, 7 Feb 2003 14:44:46 +0100, Jakob Oestergaard <jakob@unthought.net> wrote:
> > The panic has happened once, just today.
>
> I've seen this multiple times, and even reported it to the nfs mailing
> list.
>
> I'm just glad someone else is seeing the same kind of oops with a vanilla
> kernel, because I was seeing it with a heavily patched
> redhat+nfs2.4.20+nfsall2.4.20 kernel and wasn't sure if that had anything
> to do with it.
>
> I have at least 5-6 such oopsen recorded, if anyone cares.

Please send them.

Duncan.
