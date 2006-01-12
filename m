Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWALADk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWALADk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWALADk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:03:40 -0500
Received: from mx.pathscale.com ([64.160.42.68]:54483 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751181AbWALADk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:03:40 -0500
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
In-Reply-To: <adamzi2ib1g.fsf@cisco.com>
References: <1052904816d73f208585.1137019196@eng-12.pathscale.com>
	 <adamzi2ib1g.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 16:03:17 -0800
Message-Id: <1137024197.17705.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 15:45 -0800, Roland Dreier wrote:

> Sorry to keep this going still further, but I'm still confused.  Why
> can't this assembly just define __raw_memcpy_toio32() directly?

It certainly can.  I've just been buried in this bloody thing for a
little too long.

	<b

