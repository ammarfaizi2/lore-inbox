Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269695AbUJVIQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbUJVIQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270095AbUJVIMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:12:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:9135 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269745AbUJSQe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:34:58 -0400
Date: Tue, 19 Oct 2004 18:34:36 +0200
From: Andi Kleen <ak@suse.de>
To: "Pu, Long" <long.pu@intel.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: [discuss] [patch]Replace some sys32 functions with compat ones on em64T
Message-ID: <20041019163436.GH20856@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F8405460215@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405460215@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 10:57:24AM +0800, Pu, Long wrote:
>  <<x68_64_sys32_to_compat.diff>> This patch replaced some sys32 syscall
> functions of X86_64 with the corresponding compat version.
> It is against 2.6.9-rc4-mm1.
> 
> Signed-off-by: Pu Long	<long.pu@intel.com>

Thanks. Looks good.

-Andi
