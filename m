Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270930AbTGPQEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTGPQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:04:40 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:57310 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270930AbTGPQEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:04:39 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Valdis.Kletnieks@vt.edu, Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: sysfs file size wierdness (was Re: 2.6-test1-mm1 success, tiny mouse and framebuffer problems
Date: Wed, 16 Jul 2003 18:18:12 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, jsimmons@infradead.org,
       rubini@vision.unipv.it, vandrove@vc.cvut.cz
References: <3F156566.4040206@unixsol.org> <200307161611.h6GGBaLf004493@turing-police.cc.vt.edu>
In-Reply-To: <200307161611.h6GGBaLf004493@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161818.12487.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Juli 2003 18:11 schrieb Valdis.Kletnieks@vt.edu:
> On Wed, 16 Jul 2003 17:47:02 +0300, Georgi Chorbadzhiyski said:
> 
> > P.S. Every file in sysfs is 4096 bytes, is this normal?

Perhaps it is time for people to fix their tools and make those
files permanently size 0?

	Regards
		Oliver

