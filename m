Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVAQPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVAQPPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVAQPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:15:23 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63187 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261264AbVAQPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:15:20 -0500
Message-ID: <41EBD662.1080409@nortelnetworks.com>
Date: Mon, 17 Jan 2005 09:14:42 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>	 <1105827794.27410.82.camel@gaston>	 <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com> <1105937266.4534.0.camel@gaston>
In-Reply-To: <1105937266.4534.0.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Well.. the cache flush part requires some not-really-documentd stuff on
> the 970, but I'll try to come up with something.

Details?  We've got a cache-flush routine put together based on the 
documentation that seems to be working, but if there's something else 
that has to be done I'd love to know about it.

Chris
