Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUBRVcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUBRVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:32:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25348 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268166AbUBRVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:32:15 -0500
Date: Wed, 18 Feb 2004 22:27:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
Message-ID: <20040218212743.GA3175@alpha.home.local>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet> <20040218055744.GC15660@alpha.home.local> <Pine.LNX.4.58L.0402181132480.4852@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402181132480.4852@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 11:34:54AM -0300, Marcelo Tosatti wrote:
> Your fix looks ok. I dont think calling acpi_system_save_state(S5) can
> cause any breakage. Len?
> 
> We can test the patch in 2.4.26-pre1.

OK, Thanks Marcelo.
Willy

