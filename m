Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTFFBVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 21:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbTFFBVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 21:21:53 -0400
Received: from dyn-ctb-203-221-72-248.webone.com.au ([203.221.72.248]:27396
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265281AbTFFBVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 21:21:52 -0400
Message-ID: <3EDFEFBB.7080507@cyberone.com.au>
Date: Fri, 06 Jun 2003 11:34:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@austin.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nightly regression run results
References: <3EDF6F49.8070201@austin.ibm.com>
In-Reply-To: <3EDF6F49.8070201@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark Peloquin wrote:

>
>
> Here are links to some 2.5.70 nightly regression comparisons:
>
It appears your tiobench reads are coming out of cache.
Would you be able add some runs with the size >= 2*ram
please? I don't know if anyone would still find the
current type useful - maybe for scalability work?

Thanks
Nick

