Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRLMBOG>; Wed, 12 Dec 2001 20:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282969AbRLMBNq>; Wed, 12 Dec 2001 20:13:46 -0500
Received: from ns2.bizsystems.net ([63.77.172.2]:13584 "EHLO
	ns2.bizsystems.net") by vger.kernel.org with ESMTP
	id <S282968AbRLMBNq>; Wed, 12 Dec 2001 20:13:46 -0500
Message-Id: <200112130113.RAA17715@ns2.bizsystems.net>
From: "Michael" <michael@bizsystems.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Dec 2001 17:13:44 -0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.17-pre8
Reply-to: michael@bizsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There still remains an unpatched file in netfilters for 
iptables-1.2.4

net/ipv4/netfilter/ipt_TOS.c

It would be nice to complete all the patches for netfilter before 
2.4.17 is released.

Michael
