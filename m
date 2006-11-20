Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966808AbWKTVhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966808AbWKTVhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966792AbWKTVhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:37:14 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:47196 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966705AbWKTVhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:37:12 -0500
Message-ID: <4561AE31.9010407@oracle.com>
Date: Mon, 20 Nov 2006 05:31:29 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 1/4][AIO] - fix aio.h includes
References: <20061120151700.4a4f9407@frecb000686> <20061120152236.7b56c71e@frecb000686>
In-Reply-To: <20061120152236.7b56c71e@frecb000686>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué wrote:
>   Fix the double inclusion of linux/uio.h in linux/aio.h

Sure seems reasonable to me.

> Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Signed-off-by: Zach Brown <zach.brown@oracle.com>

- z
