Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWAVUfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWAVUfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAVUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:35:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61853 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751337AbWAVUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:35:01 -0500
Subject: Re: [PATCH] slab: fix sparse warning
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060122120619.5bae6004.rdunlap@xenotime.net>
References: <20060122120619.5bae6004.rdunlap@xenotime.net>
Date: Sun, 22 Jan 2006 22:34:57 +0200
Message-Id: <1137962097.8704.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, 2006-01-22 at 12:06 -0800, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> fix sparse warning:
> mm/slab.c:1522:13: error: incompatible types for operation (&)
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Looks good, thanks.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

			Pekka

