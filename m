Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVFML5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVFML5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVFML5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:57:32 -0400
Received: from us401.activeby.net ([216.32.91.22]:14250 "EHLO
	us401.activeby.net") by vger.kernel.org with ESMTP id S261499AbVFML5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:57:30 -0400
Message-ID: <42AD74A3.1050006@active.by>
Date: Mon, 13 Jun 2005 14:57:23 +0300
From: Rommer <rommer@active.by>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: udp.c
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - us401.activeby.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - active.by
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Where used strange function udp_v4_hash?
linux-2.6.11.11, net/ipv4/udp.c:204

static void udp_v4_hash(struct sock *sk)
{
	BUG();
}

-- 
Best regards, Roman
