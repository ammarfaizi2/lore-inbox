Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVI1TFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVI1TFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVI1TFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:05:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63379 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750716AbVI1TFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:05:17 -0400
Date: Wed, 28 Sep 2005 12:04:31 -0700
From: Paul Jackson <pj@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: torvalds@osdl.org, kurosawa@valinux.co.jp, taka@valinux.co.jp,
       magnus.damm@gmail.com, dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [ckrm-tech] Re: [PATCH] cpuset read past eof memory leak fix
Message-Id: <20050928120431.2a7323b8.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509281102330.14803@shark.he.net>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050928092558.61F6170041@sv1.valinux.co.jp>
	<20050928064224.49170ca7.pj@sgi.com>
	<Pine.LNX.4.58.0509280758560.3308@g5.osdl.org>
	<20050928105316.0684c7cf.pj@sgi.com>
	<Pine.LNX.4.58.0509281102330.14803@shark.he.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Paul, did you see Linus's email on the canonical patch format?

I had just found it in my archives, a few minutes earlier.  Thanks!

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
