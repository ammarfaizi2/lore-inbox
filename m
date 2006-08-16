Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWHPTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWHPTZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHPTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:25:19 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:37085 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932184AbWHPTZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:25:17 -0400
Date: Wed, 16 Aug 2006 23:24:15 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060816192415.GA19537@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <44E35F29.8010500@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44E35F29.8010500@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 23:24:21 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 11:08:41AM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> 
> >>> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
> >> 	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)
> > 
> > Ugh, no. It reduces readability due to exessive number of spaces.
> 
> Ihavetoverystronglydisagree.

W e l l , i f y o u i n s i s t a n d a b s o l u t e l y s u r e.

> - z

-- 
	Evgeniy Polyakov
