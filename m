Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUITXby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUITXby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUITXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:31:48 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:23056 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267389AbUITXbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:31:33 -0400
Message-ID: <88240e9404092016313ca56ca0@mail.gmail.com>
Date: Mon, 20 Sep 2004 16:31:32 -0700
From: TEJAS VORA <voratejas@gmail.com>
Reply-To: TEJAS VORA <voratejas@gmail.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linux-c-programming@vger.kernel.org, linux-admin@vger.kernel.org,
       linux-newbie@vger.kernel.org
Subject: Network Statistics Collection
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am working on a company project and as a part of it - I have to
collect and show some network information on the Monitoring utility.
Please help to find out that how can I collect these information from
a Linux Machine.

1. Number of active TCP connection
2. Information of Active connections (Source and Dest IP, Source and Dest Port)
3. Retransmitted packets due to Duplicate ACK and SACK
4. Connection Duration and RTT
5. Transmission Troughput (in KB/Sec)
6. Number of Newly Created TCP Connections
7. Closed TCP Connections
8. Total Data transmitted (in byte)
9. Total Data Retransmitted (in byte)

Also, does anybody have any information on Watchdaog or how to use
watchdog and SOCKS and SNOOP Daemon?
I am using RedHat 9.0 machine.

Any help is apreciated. 

Looking for an answer.

Tejas Vora
