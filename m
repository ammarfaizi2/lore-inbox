Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVAMDvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVAMDvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVAMDvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:51:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:45975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbVAMDvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:51:39 -0500
Date: Wed, 12 Jan 2005 19:51:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Prasanna Meda <pmeda@akamai.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] contort getdents64 to pacify gcc-2.96
In-Reply-To: <20050113004219.A25351@mail.kroptech.com>
Message-ID: <Pine.LNX.4.58.0501121950100.2310@ppc970.osdl.org>
References: <20050113004219.A25351@mail.kroptech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Adam Kropelin wrote:
> 
> ...gives gcc-2.96 indigestion:

Ouch. I wonder what triggers it. But your patch looks fine, so let's just 
roll with it.

		Linus
