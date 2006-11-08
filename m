Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754434AbWKHIYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbWKHIYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbWKHIYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:24:44 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56229 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754433AbWKHIYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:24:43 -0500
Date: Wed, 8 Nov 2006 11:23:42 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 1/5] kevent: Description.
Message-ID: <20061108082342.GB2447@2ka.mipt.ru>
References: <11629182482886@2ka.mipt.ru> <1162918248891@2ka.mipt.ru> <20061107141640.78a9b98c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061107141640.78a9b98c.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 08 Nov 2006 11:23:43 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 02:16:40PM -0800, Andrew Morton (akpm@osdl.org) wrote:
> On Tue, 7 Nov 2006 19:50:48 +0300
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > Description.
> 
> I converted this into Documentation/kevent.txt.  It looks like crap in an 80-col
> xterm btw.

Thanks.
It was copied as is from documentation page, so it does looks like crap
in non-browser window. I'm quite sure there will be some questions about
kevent, so I will update that file and fix indent.

-- 
	Evgeniy Polyakov
