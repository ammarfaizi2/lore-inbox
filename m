Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCOWay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCOWay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVCOW2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:28:55 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:63104 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261989AbVCOW1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:27:41 -0500
Subject: Re: [PATCH] Add missing refrigerator calls
From: Marcel Holtmann <marcel@holtmann.org>
To: ncunningham@cyclades.com
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110924757.6454.132.camel@desktop.cunningham.myip.net.au>
References: <1110924757.6454.132.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 23:27:19 +0100
Message-Id: <1110925639.9818.80.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

> There are a number of threads that currently have no refrigerator
> handling in Linus' tree. This patch addresses part of that issue. The
> remainder will be addressed in other patches, following soon.
> 
> Signed-off-by: Nigel Cunningham <ncunningham@cyclades.com>

I am fine with the net/bluetooth/rfcomm/ part, but what about the bnep/
and cmtp/ and hidp/ part of the Bluetooth subsystem? Do we need this
there, too?

Regards

Marcel


