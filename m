Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRG3X5X>; Mon, 30 Jul 2001 19:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269098AbRG3X5N>; Mon, 30 Jul 2001 19:57:13 -0400
Received: from rj.SGI.COM ([204.94.215.100]:30688 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269100AbRG3X5E>;
	Mon, 30 Jul 2001 19:57:04 -0400
Subject: many file descriptors
From: Florin Andrei <florin@sgi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11 (Beta Release)
Date: 30 Jul 2001 16:57:11 -0700
Message-Id: <996537431.16247.94.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Is there any problem if i increase the max number of file descriptors to
a very large value, say 16384 (echo 16384 > /proc/sys/fs/file-max)?

(kernel-2.4.7, on a dual PIII with 1 GB RAM, running Squid as a very
busy proxy server)

--
Florin Andrei

