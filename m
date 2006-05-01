Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWEAXbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWEAXbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWEAXbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:31:17 -0400
Received: from [198.99.130.12] ([198.99.130.12]:12427 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932327AbWEAXbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:31:16 -0400
Date: Mon, 1 May 2006 18:31:38 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] UML - Change timer initialization
Message-ID: <20060501223138.GA6446@ccure.user-mode-linux.org>
References: <200605012046.k41KkURr005868@ccure.user-mode-linux.org> <20060501145837.1069e19e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501145837.1069e19e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 02:58:37PM -0700, Andrew Morton wrote:
> Which means nobody's tested uml against the last couple of -mm's.  Bad.

Yeah.

I didn't check rc2-mm1 because it came out after rc3, and I missed
rc1-mm3.  But rc1-mm2 was OK.

				Jeff
