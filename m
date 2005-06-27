Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVF0VUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVF0VUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVF0VTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:19:10 -0400
Received: from relay1.wplus.net ([195.131.52.143]:24372 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S261853AbVF0VRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:17:48 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 01:08:34 +0400
User-Agent: KMail/1.7.1
Cc: Reuben Farrelly <reuben-lkml@reub.net>, vitaly@thebsh.namesys.com,
       "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <fa.d8odcmh.1u56sbb@ifi.uio.no> <42BE5058.4070307@reub.net> <42BEFC77.6000608@namesys.com>
In-Reply-To: <42BEFC77.6000608@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506280108.35265.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 23:05, Hans Reiser wrote:
> Reuben Farrelly wrote:
> 
> > Hi Hans,
> >
> > On 25/06/2005 12:38 a.m., Hans Reiser wrote:
> >
> >> fsck is better in V4 than it is in V3. Users should move from V3 to V4,
> >> as V3 is obsolete. I agree on that Ted.
> >
> >
> > Perhaps before moving to V4, reiser4progs-1.04 (the most recent I
> > think) could be made to compile with gcc4/fedora core 4 system, and
> > some of the warnings cleaned up.  There are a fair lot of them - all
> > the same warnings as below but in a heap of different files.
> >
> I will ask Vitaly to look into this.  None of us at Namesys use fedora.....
> 
> Vitaly?

yes, I will investigate the problem.

-- 
Thanks,
Vitaly Fertman
