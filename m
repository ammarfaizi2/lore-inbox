Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUIBX1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUIBX1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUIBXML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:12:11 -0400
Received: from mail.gbg.bostream.net ([81.26.226.10]:62382 "EHLO
	mail.gbg.bostream.net") by vger.kernel.org with ESMTP
	id S269185AbUIBXIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:08:40 -0400
In-Reply-To: <20040902152214.2b3d5cb9.davem@davemloft.net>
References: <Pine.LNX.4.44.0409030003200.1068-100000@quetzalcoatlite.e.kth.se> <20040902152214.2b3d5cb9.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03BF8E7E-FD35-11D8-B5CD-000D93685E26@e.kth.se>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Per von Zweigbergk <pvz@e.kth.se>
Subject: Re: CONFIG_BSD_DISKLABEL not in 2.6.8.1?
Date: Fri, 3 Sep 2004 01:08:34 +0200
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2004-09-03 kl. 00.22 skrev David S. Miller:

> Enable CONDIG_PARTITION_ADVANCED and CONFIG_MSDOS_PARTITION,
> this will enable selection of CONFIG_BSD_DISKLABEL.

Okay, I'll try that. Is this documented somewhere?

