Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992438AbWJTCxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992438AbWJTCxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992440AbWJTCxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:53:00 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:51853 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S2992438AbWJTCxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:53:00 -0400
Date: Thu, 19 Oct 2006 19:54:25 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David KOENIG <karhudever@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Converted jiffy comparisons to time_after calls (TAKE
 3)
Message-Id: <20061019195425.e4265a94.randy.dunlap@oracle.com>
In-Reply-To: <200610191942.26865.karhudever@gmial.com>
References: <200610191942.26865.karhudever@gmial.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 19:42:26 -0700 David KOENIG wrote:

> >From 9180d29946eced4c71845c9bbe847e98e01d1c31 Mon Sep 17 00:00:00 2001
> From: David KOENIG <david@karhu.(none)>
> Date: Thu, 19 Oct 2006 18:57:17 -0700
> Subject: [PATCH] Converted jiffy comparisons to time_after calls
> ---
>  drivers/net/tokenring/3c359.c |   21 +++++++++++----------
>  1 files changed, 11 insertions(+), 10 deletions(-)

Yes, like that.  Thanks.

---
~Randy
