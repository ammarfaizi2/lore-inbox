Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759293AbWLBGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293AbWLBGsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759346AbWLBGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 01:48:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32746 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1759293AbWLBGsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 01:48:40 -0500
Date: Fri, 1 Dec 2006 22:51:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux-stable <stable@kernel.org>
Subject: Re: [stable] [patch] crypto: cryptoloop requires CBC
Message-ID: <20061202065122.GI1397@sequoia.sous-sol.org>
References: <200612012342_MC3-1-D39B-996E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612012342_MC3-1-D39B-996E@compuserve.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:
> Kernel builds but cryptoloop won't work without CBC crypto
> algorithm in kernel 2.6.19.

Thanks, Herbert sent that already (both to stable and in his
git pull request to Linus).

-chris
