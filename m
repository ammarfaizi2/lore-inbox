Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSL3SX7>; Mon, 30 Dec 2002 13:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSL3SX6>; Mon, 30 Dec 2002 13:23:58 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:62853 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267038AbSL3SX6> convert rfc822-to-8bit; Mon, 30 Dec 2002 13:23:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Neukum <oliver@neukum.name>
To: linux-kernel@vger.kernel.org
Subject: question on context of kfree_skb()
Date: Mon, 30 Dec 2002 19:32:15 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212301932.15175.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting reports about kfree_skb being called in hard IRQ.
Which context should it be called in?

	Regards
		Oliver

