Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRBPJuJ>; Fri, 16 Feb 2001 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130074AbRBPJt7>; Fri, 16 Feb 2001 04:49:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130235AbRBPJtr>; Fri, 16 Feb 2001 04:49:47 -0500
Subject: Re: mke2fs and kernel VM issues
To: sflory@valinux.com (Samuel Flory)
Date: Fri, 16 Feb 2001 09:48:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, tytso@valinux.com (tytso@valinux.com)
In-Reply-To: <3A8C85B9.610D0C06@valinux.com> from "Samuel Flory" at Feb 15, 2001 05:43:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ThUy-0002ed-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
> believed to be a known good kernel?  (both 2.2.x and 2.4.x)

I've not seen the problem on unmodified 2.2.18. The 2.2.17/18 VM does have
its problems but not these. 2.2.19pre3 and higher have the Andrea VM fixes which
have worked wonders for everyone so far. 
