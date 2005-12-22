Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVLVNuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLVNuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVLVNuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:50:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932460AbVLVNuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:50:21 -0500
Date: Thu, 22 Dec 2005 05:46:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Truong, Dan" <dan.truong@hp.com>
Cc: stephane.eranian@hp.com, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [perfmon] Re: quick overview of the perfmon2 interface
Message-Id: <20051222054644.0b9da029.akpm@osdl.org>
In-Reply-To: <3C87FFF91369A242B9C9147F8BD0908A02C69459@cacexc04.americas.cpqcorp.net>
References: <3C87FFF91369A242B9C9147F8BD0908A02C69459@cacexc04.americas.cpqcorp.net>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Truong, Dan" <dan.truong@hp.com> wrote:
>
> The PMU is becoming a standard commodity. Once Perfmon is
> "the" Linux interface, all the tools can align on it and
> coexist, push their R&D forward, and more importantly become
> fully productized for businesses usage.
>

The apparently-extreme flexibility of the perfmon interfaces would tend to
militate against that, actually.  It'd become better productised if it had
one interface and stuck to it.

(I haven't processed Stephane's reply yet - will get there)

