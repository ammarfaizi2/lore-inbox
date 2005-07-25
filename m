Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVGYGGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVGYGGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGYGEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:04:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261735AbVGYGCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:02:32 -0400
Date: Mon, 25 Jul 2005 02:02:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@davemloft.net>
cc: johnpol@2ka.mipt.ru, Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@redhat.com
Subject: Netlink connector
In-Reply-To: <20050724.191756.105797967.davem@davemloft.net>
Message-ID: <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru>
 <20050724.191756.105797967.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005, David S. Miller wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Sat, 23 Jul 2005 13:14:55 +0400
>
>> Andrew has no objection against connector and it lives in -mm
>
> A patch sitting in -mm has zero significance.

The significance I think is that Andrew is trying to gently encourage some 
further progress in the area.

I recall some netconf discussion about TIPC over Netlink, or more likely a 
variation thereof, which may be a better way forward.

It's cool stuff http://tipc.sourceforge.net/


- James
-- 
James Morris
<jmorris@redhat.com>

