Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUAIFRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 00:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUAIFRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 00:17:12 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:61028 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265652AbUAIFRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 00:17:11 -0500
Date: Thu, 8 Jan 2004 21:17:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: akpm@osdl.org, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org
Subject: Re: [2.6 patch] use range for NR_CPUS
Message-Id: <20040108211706.7772da92.pj@sgi.com>
In-Reply-To: <20040109013850.GI13867@fs.tum.de>
References: <20040109013850.GI13867@fs.tum.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The help text on ia64 didn't suggest any values. Could someone tell the 
> correct values for ia64 (and if it's only a minimum value of 2)?

It keeps moving.  We've announced experimental versions up to 512 CPUs,
I believe.  We being SGI, and our SN product, which uses ia64 arch.  So
I guess you can put that in.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
