Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263613AbUD0AhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbUD0AhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUD0AhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:37:06 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38515 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263613AbUD0AhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:37:04 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Date: Mon, 26 Apr 2004 17:36:47 -0700
User-Agent: KMail/1.6.1
Cc: Chris Wright <chrisw@osdl.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net>
In-Reply-To: <20040426163955.X21045@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404261736.47522.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 26, 2004 4:39 pm, Chris Wright wrote:
> * Erik Jacobson (erikj@subway.americas.sgi.com) wrote:
> > Here, I am proposing Process Aggregates support for the 2.6 kernel.
>
> This looks like it's just the infrastructure, i.e. nothing is using it.
> It seems like PAGG could be done on top of CKRM (albeit, with more
> code).  But if the goal is to do some basic accounting, scheduling, etc.
> on a resource group, wouldn't CKRM be more generic?

Quite possibly.  Do you have a pointer to the latest bits/design docs?

Thanks,
Jesse
