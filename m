Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTEMXox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEMXox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:44:53 -0400
Received: from tetsuo.zabbo.net ([208.187.215.57]:49815 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262360AbTEMXov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:44:51 -0400
Message-ID: <3EC18670.8070103@zabbo.net>
Date: Tue, 13 May 2003 16:57:36 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
References: <20030513133636.C2929@us.ibm.com>	<20030513152141.5ab69f07.akpm@digeo.com>	<3EC17BA3.7060403@zabbo.net> <20030513161938.1fc00a5e.akpm@digeo.com>
In-Reply-To: <20030513161938.1fc00a5e.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In 2.5, page->buffers was abstracted out to page->private, and is available
> to filesystems for functions such as this.

that's great news!

> When you finally decide to do your development in a development kernel ;)

customers seem to have the strangest aversion to  development kernels :)

but, yeah, I should be doing 2.5 work soon and will holler if
simplifications make themselves apparent.

- z

