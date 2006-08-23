Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWHWJTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWHWJTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWHWJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:19:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51405 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751470AbWHWJTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:19:04 -0400
Date: Wed, 23 Aug 2006 13:18:13 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 1/3] kevent: Core files.
Message-ID: <20060823091813.GA20014@2ka.mipt.ru>
References: <115615558935@2ka.mipt.ru> <200608231051.37089.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200608231051.37089.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 13:18:21 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:51:36AM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> Hello Evgeniy

Hi Eric.
 
> I have one comment/suggestion (minor detail, your work is very good)
> 
> I suggest to add one item in kevent_registered_callbacks[], so that 
> kevent_registered_callbacks[KEVENT_MAX] is valid and can act as a fallback.

Sounds good, could you please send appliable patch with proper
signed-off line?

> Eric Dumazet

-- 
	Evgeniy Polyakov
