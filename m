Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVLJU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVLJU1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbVLJU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:27:53 -0500
Received: from www.nabble.com ([72.21.53.35]:52386 "EHLO talk.nabble.com")
	by vger.kernel.org with ESMTP id S1161062AbVLJU1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:27:53 -0500
Message-ID: <1883148.post@talk.nabble.com>
Date: Sat, 10 Dec 2005 08:32:56 -0800 (PST)
From: "Ferrari (sent by Nabble.com)" <lists@nabble.com>
Reply-To: Ferrari <dubeyravi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Ethernet bridge leaking memory
In-Reply-To: <20051110130613.2bb0c9be@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-Sender: Nabble Forums <lists@nabble.com>
X-Nabble-From: Ferrari <dubeyravi@gmail.com>
References: <200511102113.28334.kostja@siefen.de> <20051110130613.2bb0c9be@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Have you find the answer to this problem?

I also have a bridge setup between a 802.11 wireless interface and a 802.3 interface. When I run UDP traffic at a fast rate, the skbuff_head_cache values goes up and UP..

Could someone throw some light on this.

I am running 2.4.20 kernel on this.

Ravi
--
Sent from the linux-kernel forum at Nabble.com:
http://www.nabble.com/Ethernet-bridge-leaking-memory-t529532.html#a1883148

