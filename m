Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWJ2Qm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWJ2Qm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWJ2Qm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:42:28 -0500
Received: from ns.suse.de ([195.135.220.2]:49599 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965288AbWJ2Qm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:42:27 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 3/7] More generic paravirtualization entry point.
Date: Sun, 29 Oct 2006 08:41:37 -0800
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <20061029024605.950760000@sous-sol.org>
In-Reply-To: <20061029024605.950760000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610290841.38032.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 00:00, Chris Wright wrote:

> +
> +/* We simply declare start_kernel to be the paravirt probe of last resort.
> */ +asmlinkage void __init start_kernel(void);

Didn't rusty put that into a header recently?

-Andi

