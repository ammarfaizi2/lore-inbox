Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWJLUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWJLUyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJLUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:54:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWJLUyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:54:38 -0400
Date: Thu, 12 Oct 2006 13:54:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00 of 23][-mm] Unionfs: Stackable Namespace Unification
 Filesystem
Message-Id: <20061012135428.024d0d33.akpm@osdl.org>
In-Reply-To: <patchbomb.1160633917@thor.fsl.cs.sunysb.edu>
References: <patchbomb.1160633917@thor.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 02:18:37 -0400
Josef "Jeff" Sipek <jsipek@cs.sunysb.edu> wrote:

> This set of patches constitutes Unionfs version 2.0.

So we need to get this reviewed.

Christoph and I are pretty much the only people who do filesystem
reviewing, despite the fact that we have hoards of filesystem developers
out there busily doing their own stuff (and that includes the unionfs
developers, I might add).

Our review-to-development ratio is wildly out of whack and I don't know how
to fix that.

Meanwhile, from a quick scan I'd say that unionfs is much, much too lightly
commented for a review to be particularly effective.   Please work on that.

