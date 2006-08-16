Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWHPSJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWHPSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWHPSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:09:29 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:55415 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751242AbWHPSJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:09:28 -0400
Message-ID: <44E35F29.8010500@oracle.com>
Date: Wed, 16 Aug 2006 11:08:41 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [take9 1/2] kevent: Core files.
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru>
In-Reply-To: <20060816135642.GD4314@2ka.mipt.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
>> 	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)
> 
> Ugh, no. It reduces readability due to exessive number of spaces.

Ihavetoverystronglydisagree.

- z
