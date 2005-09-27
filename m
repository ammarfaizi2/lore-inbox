Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVI0Pxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVI0Pxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVI0Pxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:53:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61913 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964989AbVI0Pxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:53:44 -0400
Date: Tue, 27 Sep 2005 08:53:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
Message-Id: <20050927085319.074ff4b1.pj@sgi.com>
In-Reply-To: <1127812937.5174.6.camel@npiggin-nld.site>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<1127812937.5174.6.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> this code looks much neater than the code I reviewed.

This does not surprise me.  Takahiro-san writes nice code.

I will abstain from picking one cpu controller over another,
as that is not an area of my expertise.  But I definitely
agree with your hope:

> to have just a single CPU resource controller 

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
