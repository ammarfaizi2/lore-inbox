Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWGJL7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWGJL7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWGJL7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:59:37 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:48550 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S964934AbWGJL7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:59:36 -0400
Date: Mon, 10 Jul 2006 14:59:55 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] IB/mthca: comment fix
Message-ID: <20060710115955.GF24705@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1152531909.4874.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152531909.4874.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 12:04:32.0781 (UTC) FILETIME=[0131B3D0:01C6A419]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Arjan van de Ven <arjan@infradead.org>:
> makes sense to me; my main concern is that we document the bug that was
> there; unless you document such things.. these bugs tend to have a habit
> of resurfacing later ;)

Right. Although lockdep will catch this one quickly :)

-- 
MST
