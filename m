Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUFIWag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUFIWag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFIWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:30:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46459 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266014AbUFIWae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:30:34 -0400
Date: Wed, 9 Jun 2004 15:29:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] CPU_MASK_NONE fix
Message-Id: <20040609152949.308b1ec1.pj@sgi.com>
In-Reply-To: <200406092049.i59KnW9D000615@alkaid.it.uu.se>
References: <200406092049.i59KnW9D000615@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maikael wrote:
> 2.6.7-rc3-mm1 changed CPU_MASK_NONE into something that isn't

I believe that Bill Irwin also snuck this fix into his irqaction->mask
patch, posted Wed, 9 Jun 2004 10:59:10 -0700.

Thanks, Bill and Mikael, for your fixes to the dreaded -;) cpumask patch.

Thanks, Andrew, for including it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
