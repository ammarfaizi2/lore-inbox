Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163298AbWLGUxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163298AbWLGUxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163335AbWLGUxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:53:31 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:47522 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163333AbWLGUxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:53:31 -0500
To: "Komal Shah" <komal.shah802003@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gen_pool_destroy(...)?
References: <3a5b1be00611210829p75f44b1fu7ba6fde807fb530e@mail.gmail.com>
From: Jes Sorensen <jes@sgi.com>
Date: 07 Dec 2006 15:53:30 -0500
In-Reply-To: <3a5b1be00611210829p75f44b1fu7ba6fde807fb530e@mail.gmail.com>
Message-ID: <yq03b7rv35h.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Komal" == Komal Shah <komal.shah802003@gmail.com> writes:

Komal> Hi, Why we don't have gen_pool_destroy(...) like
Komal> mempool_destroy(...)? As of now I can only see the application
Komal> of genalloc function in ia64/uncached.c file only.

Well, we didn't need it so it wasn't considered. I don't see any
reason why it couldn't be added.

Cheers,
Jes
