Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWHXRTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWHXRTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWHXRTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:19:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14745 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030398AbWHXRTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:19:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824155814.GL19810@stusta.de> 
References: <20060824155814.GL19810@stusta.de>  <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 18:18:27 +0100
Message-ID: <17931.1156439907@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
> possible, and I really know what I'm doing" people.

It's not a speed thing so much as a space thing.

David
