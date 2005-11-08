Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVKHH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKHH6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVKHH6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:58:48 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30665 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750732AbVKHH6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:58:48 -0500
Date: Tue, 8 Nov 2005 09:58:32 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: [PATCH 0/8] Cleanup slab.c
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0511080956110.10273@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Matthew Dobson wrote:
> Since there was some (albeit very brief) discussion last week about the
> need to cleanup mm/slab.c, I figured I'd post these patches.  I was
> inspired to cleanup mm/slab.c since I'm working on a project (to be posted
> shortly) that touched a bunch of slab code.  I found slab.c to be
> inconsistent, to say the least.

Thank you for doing this. Overall, they look good to me except for the 
bits I commented on. In future, please inline patches to the mail and cc
Manfred Spraul who more or less maintains mm/slab.c (curiously, I see no
entry in MAINTAINERS though).

			Pekka
