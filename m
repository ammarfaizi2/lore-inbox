Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWCJRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCJRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCJRyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:54:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14556 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751170AbWCJRyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:54:24 -0500
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another
	round for review
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Grant Grundler <iod00d@hp.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
In-Reply-To: <20060310174806.GA13969@esmail.cup.hp.com>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <20060310153559.GA12778@mellanox.co.il>
	 <1142006537.29925.13.camel@serpentine.pathscale.com>
	 <20060310174806.GA13969@esmail.cup.hp.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 09:54:19 -0800
Message-Id: <1142013259.29925.69.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:48 -0800, Grant Grundler wrote:

> My gut feeling is you want to look at SDP first.

We already implement SDP.

> I'm skeptical that yet another wire protocol will get
> accepted into the linux kernel.

It's just a simple net device driver.

	<b

