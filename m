Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbVKIUiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbVKIUiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbVKIUiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:38:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:11693 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161230AbVKIUiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:38:06 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051109172125.GA12861@lst.de>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston>  <20051109172125.GA12861@lst.de>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 07:36:29 +1100
Message-Id: <1131568589.24637.93.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 18:21 +0100, Christoph Hellwig wrote:
> Booting current mainline with 64K pagesize enabled gives me a purple (!)
> screen early during boot.

On the G5 ? Weird... I'll test.

Ben.


