Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbULNJzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbULNJzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULNJzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:55:55 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:23980 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261472AbULNJzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:55:45 -0500
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Max Krasnyansky <maxk@qualcomm.com>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
In-Reply-To: <20041214094543.GA963@infradead.org>
References: <20041214041352.GZ23151@stusta.de>
	 <1103009649.2143.65.camel@pegasus>  <20041214094543.GA963@infradead.org>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 10:54:59 +0100
Message-Id: <1103018099.2143.127.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> > these functions must stay. They have users outside the mainline kernel
> > that are not merged back yet. Otherwise they won't be exported ;)
> 
> But we traditionally don't keep APIs only for the sake of external modules.
> Exceptions are made if you have short- to mid-term plans to merge them.

it is a short term plan, because otherwise I won't have submitted it in
the first place. And as I said, they are not merged back yet. They are
not tested enough for mainline at the moment.

Regards

Marcel


