Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUCAOmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUCAOl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:41:59 -0500
Received: from mail.timesys.com ([65.117.135.102]:5896 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261310AbUCAOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:40:07 -0500
Message-ID: <40434B45.1090106@timesys.com>
Date: Mon, 01 Mar 2004 09:40:05 -0500
From: "Steven J. Hill" <Steve.Hill@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Make linux/swap.h usable by userspace code.
References: <4043498F.7050101@timesys.com> <20040301143606.A6460@infradead.org>
In-Reply-To: <20040301143606.A6460@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2004 14:32:36.0218 (UTC) FILETIME=[0A77DDA0:01C3FF9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Gack.  Including swap.h is really silly.  Fix ltp to not do such things
> instead.
>
Fine, then let's just remove the #ifdef __KERNEL__ all together then.

-Steve
