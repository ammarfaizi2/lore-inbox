Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbVI1Gns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbVI1Gns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVI1Gns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:43:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26762 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751124AbVI1Gnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:43:46 -0400
Date: Tue, 27 Sep 2005 23:43:31 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
Message-Id: <20050927234331.7521478a.pj@sgi.com>
In-Reply-To: <20050928062146.6038E70041@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20050928062146.6038E70041@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san wrote:
> Maybe the default value of meter_cpu_guar (guarantee) could be 0 
> in this design, since guarantee 0 means no guarantee.

Ah yes - that is a better default.  Excellent.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
