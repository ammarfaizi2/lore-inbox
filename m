Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSGJRl7>; Wed, 10 Jul 2002 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGJRl6>; Wed, 10 Jul 2002 13:41:58 -0400
Received: from holomorphy.com ([66.224.33.161]:25232 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317572AbSGJRl5>;
	Wed, 10 Jul 2002 13:41:57 -0400
Date: Wed, 10 Jul 2002 10:43:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bob Miller <rem@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.25 remove global semaphore_lock spin lock.
Message-ID: <20020710174343.GA27093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bob Miller <rem@osdl.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020710101639.A18859@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020710101639.A18859@doc.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 10:16:39AM -0700, Bob Miller wrote:
[indispensible patch]

What??? This hasn't been merged already?


Linus, please apply. This patch has worked well for me in the past,
and does no more than remove what I consider obsolete debugging code.


Thanks,
Bill
