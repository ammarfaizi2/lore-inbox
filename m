Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbRGWJih>; Mon, 23 Jul 2001 05:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268169AbRGWJi2>; Mon, 23 Jul 2001 05:38:28 -0400
Received: from mailgw2.netvision.net.il ([194.90.1.9]:14525 "EHLO
	mailgw2.netvision.net.il") by vger.kernel.org with ESMTP
	id <S268170AbRGWJiP>; Mon, 23 Jul 2001 05:38:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Aviv Greenberg <deca@netvision.net.il>
Reply-To: deca@netvision.net.il
To: linux-kernel@vger.kernel.org
Subject: tcp_write_space
Date: Mon, 23 Jul 2001 12:37:02 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072312370200.19071@aviv_linuxddd>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Why isn't the sk->callback_lock aquired in the tcp_write_space
callback ??

Is this intentional ?

-- 
	- Aviv Greeberg
