Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVDYUwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDYUwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDYUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:52:49 -0400
Received: from smtp.istop.com ([66.11.167.126]:58279 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261174AbVDYUwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:52:23 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Mon, 25 Apr 2005 16:52:27 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050425151136.GA6826@redhat.com>
In-Reply-To: <20050425151136.GA6826@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251652.27840.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Monday 25 April 2005 11:11, David Teigland wrote:
> We've done a lot of work in this second version to meet the kernel's
> conventions.  Comments and suggestions are welcome; we're happy to answer
> questions and make changes so this can be a widely useful feature for
> people running Linux clusters.

Good luck with this.  A meta-comment: you used to call it gdlm, right?  I 
think it would be a very good idea to return to that name, unless you think 
that this will be the only dlm in linux, ever.

Regards,

Daniel
