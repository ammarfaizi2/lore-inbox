Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUBOP1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUBOP1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:27:08 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:23767 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264974AbUBOPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:24:55 -0500
Date: Sun, 15 Feb 2004 16:20:57 +0100
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re[2]: e1000 problems in 2.6.x
Message-ID: <20040215152057.GA582@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Seen: false
X-ID: Eq0mwsZ1oeikuin7dQz5k9F47pP4jQ9LaOXpiJEJB-hfZgvW1tjtE2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan-S2665 mobo which has an intergrated
e1000 and I never saw such errors with 2.6 kernels. 

I use it with 100-MBit Full-Duplex in a switched 
private network.

CONFIG_IP_MULTICAST=y
CONFIG_E1000=y
CONFIG_E1000_NAPI=y

-- 
Klaus
