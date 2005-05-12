Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVELMvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVELMvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVELMvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:51:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:9952 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261828AbVELMvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:51:46 -0400
Date: Thu, 12 May 2005 14:51:45 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: never block forced SIGSEGV
Message-ID: <20050512125145.GK15690@wotan.suse.de>
References: <200505120114.j4C1EVrr023955@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505120114.j4C1EVrr023955@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 06:14:31PM -0700, Roland McGrath wrote:
> This is the x86_64 version of the signal fix I just posted for i386.

Patch looks good, thanks.

-Andi

