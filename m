Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWI0OBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWI0OBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWI0OBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:01:39 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:27568 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932158AbWI0OBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:01:38 -0400
Date: Wed, 27 Sep 2006 10:00:20 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] UML - file renaming
Message-ID: <20060927140020.GE4367@ccure.user-mode-linux.org>
References: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org> <20060926204224.e365734f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926204224.e365734f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 08:42:24PM -0700, Andrew Morton wrote:
> So if any of these changes were made to process_kern.c, you've lost 'em.

I'll check the next -mm and send fixes if any are needed.

> They shouldn't have been: please do code-moving and code-changing within
> distinct patches.

OK.

> btw, it'd be nice to change your scripts to add a diffstat after the ^---.

OK, will do.

				Jeff
