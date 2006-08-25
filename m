Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422894AbWHYUSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWHYUSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWHYUSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:18:51 -0400
Received: from mx.pathscale.com ([64.160.42.68]:56461 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422894AbWHYUSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:18:50 -0400
Subject: Re: [PATCH 11 of 23] IB/ipath - add new minor device to allow
	sending of diag packets
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada7j0wtx0d.fsf@cisco.com>
References: <8743e6ee09c51e799f0f.1156530276@eng-12.pathscale.com>
	 <ada7j0wtx0d.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 13:20:24 -0700
Message-Id: <1156537224.31531.40.camel@sardonyx>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 12:50 -0700, Roland Dreier wrote:

> The last line adds trailing whitespace, which git complains about.
> When patchbombing, can you run your patches through "git apply --check
> --whitespace=error-all" or the equivalent?

Sure.  Thanks for spotting that.

	<b

