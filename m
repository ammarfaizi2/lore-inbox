Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHYUSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHYUSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHYUSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:18:21 -0400
Received: from mx.pathscale.com ([64.160.42.68]:51853 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932236AbWHYUSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:18:20 -0400
Subject: Re: [PATCH 1 of 23] IB/ipath - More changes to support InfiniPath
	on PowerPC 970 systems
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>, Brendan Cully <brendan@kublai.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adabqq8tx9z.fsf@cisco.com>
References: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com>
	 <adabqq8tx9z.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 13:19:54 -0700
Message-Id: <1156537194.31531.38.camel@sardonyx>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 12:45 -0700, Roland Dreier wrote:
> How did you generate these patches?

Using Mercurial.  

> because the line
> 
> diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
> 
> makes git think it's a git diff, but git doesn't put dates on the
> filename lines.

Ah, interesting.  Looks like a bug in the git-compatible patch
generator, then.  Sorry about that.

	<b

