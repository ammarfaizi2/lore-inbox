Return-Path: <linux-kernel-owner+w=401wt.eu-S965055AbWLTNri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWLTNri (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWLTNri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:47:38 -0500
Received: from brick.kernel.dk ([62.242.22.158]:29099 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965055AbWLTNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:47:37 -0500
Date: Wed, 20 Dec 2006 14:49:24 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
Message-ID: <20061220134924.GG10535@kernel.dk>
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219.171150.75425661.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
> This patch adds new "end_io_first" hook in __end_that_request_first()
> for request-based device-mapper.

What's this for, lack of stacking?

-- 
Jens Axboe

