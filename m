Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVKIRV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVKIRV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbVKIRVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:21:55 -0500
Received: from verein.lst.de ([213.95.11.210]:7866 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030522AbVKIRVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:21:53 -0500
Date: Wed, 9 Nov 2005 18:21:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: 64K pages support
Message-ID: <20051109172125.GA12861@lst.de>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130916198.20136.17.camel@gaston>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting current mainline with 64K pagesize enabled gives me a purple (!)
screen early during boot.

