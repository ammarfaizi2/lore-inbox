Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSKTVLU>; Wed, 20 Nov 2002 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKTVLU>; Wed, 20 Nov 2002 16:11:20 -0500
Received: from ns.splentec.com ([209.47.35.194]:8198 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262620AbSKTVLT>;
	Wed, 20 Nov 2002 16:11:19 -0500
Message-ID: <3DDBFC16.BFCA3012@splentec.com>
Date: Wed, 20 Nov 2002 16:18:14 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
References: <3DDBF413.C06DAF2E@splentec.com> <20021120160659.D2854@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> Erm, you just truncated a long to an int.

Yep, totally forgot about no type == int, hehehhee.

Boy, last time I thought about that _rule_ was over 12 years ago...

-- 
Luben
