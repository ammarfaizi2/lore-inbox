Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTFLW72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTFLW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:59:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265036AbTFLW7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:59:20 -0400
Date: Thu, 12 Jun 2003 16:14:52 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@digeo.com>, <sdake@mvista.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <20030612230910.GA1896@kroah.com>
Message-ID: <Pine.LNX.4.44.0306121614360.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pat, here's a patch to add a sequence number to kobject hotplug calls to
> help userspace out a lot.

Thanks, applied.


	-pat

