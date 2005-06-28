Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVF2CfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVF2CfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVF2CfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:35:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262265AbVF1Xd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:33:26 -0400
Date: Tue, 28 Jun 2005 16:33:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] freevxfs: remove 2.4 compatability
Message-Id: <20050628163338.321e3216.akpm@osdl.org>
In-Reply-To: <iit0hc.owmgrf.a8mlfisjmja2ab31fpl1ysmkp.refire@cs.helsinki.fi>
References: <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
	<iit0hc.owmgrf.a8mlfisjmja2ab31fpl1ysmkp.refire@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch removes 2.4 compatability header from freevxfs.

Maybe.  That's a bit of a pain if someone is actually maintaining this one
codebase under both kernels though...
