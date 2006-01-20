Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWATWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWATWYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWATWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:24:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932082AbWATWYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:24:03 -0500
Date: Fri, 20 Jan 2006 14:22:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Truong, Dan" <dan.truong@hp.com>
Cc: stephane.eranian@hp.com, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [perfmon] Re: quick overview of the perfmon2 interface
Message-Id: <20060120142247.28153379.akpm@osdl.org>
In-Reply-To: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Truong, Dan" <dan.truong@hp.com> wrote:
>
> Would you want Stephane to guard the extended
> functionalities with tunables or something to
> Disable their regular use and herd enterprise
> Tools into a standard mold... yet allow R&D to
> Move on by enabling the extentions?

argh.  I'd prefer to avoid one-month gaps in the conversation, so we don't
all forget what we were talking about.

Look, we just need to get these patches on the wire so we can all look at
them, see what they do, understand what decisions were taken and why.

The conciseness and completeness of those patches' covering descriptions
will be key to helping this process along.
