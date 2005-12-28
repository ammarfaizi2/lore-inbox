Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVL1PwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVL1PwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVL1PwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:52:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13235 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932435AbVL1PwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:52:09 -0500
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.62.0512281617190.10103@pademelon.sonytel.be>
References: <patchbomb.1135726914@eng-12.pathscale.com>
	 <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
	 <20051228035231.GA3356@waste.org>
	 <Pine.LNX.4.62.0512281617190.10103@pademelon.sonytel.be>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 07:52:03 -0800
Message-Id: <1135785123.1527.114.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 16:18 +0100, Geert Uytterhoeven wrote:

> BTW, does the original loop really work?

I had to turn it into a for loop shortly after I posted it, for exactly
the reason you pointed out.

	<b

