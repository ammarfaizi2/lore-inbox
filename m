Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264098AbTCXEnP>; Sun, 23 Mar 2003 23:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264099AbTCXEnP>; Sun, 23 Mar 2003 23:43:15 -0500
Received: from f159.pav2.hotmail.com ([64.4.37.159]:16395 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264098AbTCXEnO>;
	Sun, 23 Mar 2003 23:43:14 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: ips@ece.cmu.edu, linux-kernel@vger.kernel.org
Subject: Assinging IP sin_addr in kernel space
Date: Mon, 24 Mar 2003 04:54:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F159GPDcHO6YrKpRODr0000c019@hotmail.com>
X-OriginalArrivalTime: 24 Mar 2003 04:54:16.0843 (UTC) FILETIME=[6C572DB0:01C2F1C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
This is a very basic doubt I suppose, but I am not able to figure out.

If I want to send a message to IP addrs 158.168.1.1 using sockets, how to 
assign sock_data.sin_addr.s_addrs with the above IP, if I am assigning this 
in a kernel module, where functions like gethostbyname() is not avaliable to 
me.

Your help will very valuable.

Thanking You
Shesha



_________________________________________________________________
Get more buddies in your list. Win prizes http://messenger.msn.co.in/promo

