Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272801AbTHPHRS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 03:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272804AbTHPHRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 03:17:18 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:18860 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S272801AbTHPHRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 03:17:17 -0400
Date: Sat, 16 Aug 2003 10:17:11 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0test3mm2oops in mm/filemap:1930
In-Reply-To: <1060959361.744.1.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.56.0308161016570.20884@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308151537300.20496@hosting.rdsbv.ro>
 <1060959361.744.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Felipe Alfaro Solana wrote:

> On Fri, 2003-08-15 at 14:39, Catalin BOIE wrote:
>
> > kernel BUG at mm/filemap.c:1930!
>
> Please, edit file mm/filemap.c and delete the line #1930. It's a BUG_ON
> directive which can be safely ignored. Then, recompile.

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
