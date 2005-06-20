Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVFTHh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVFTHh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFTHh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:37:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbVFTHhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:37:21 -0400
Date: Mon, 20 Jun 2005 00:36:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, mason@suse.de
Subject: Re: [patch 2/2] stats for orphaned pages (-mm only)
Message-Id: <20050620003647.283ba186.akpm@osdl.org>
In-Reply-To: <1119252269.6240.25.camel@npiggin-nld.site>
References: <1118978590.5261.4.camel@npiggin-nld.site>
	<1119252194.6240.22.camel@npiggin-nld.site>
	<1119252269.6240.25.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> And this.
> 
> ...
> 
> [vm-orphaned-debug.patch  text/x-patch (3472 bytes)]

yup.  Observing the chnages in these numbers across various workloads would
go a long way toward validating the need for some patch and toward
validating a particular patch's effectiveness too.
