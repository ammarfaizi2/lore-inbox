Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSICDfZ>; Mon, 2 Sep 2002 23:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318638AbSICDfZ>; Mon, 2 Sep 2002 23:35:25 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:24796
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S318635AbSICDfZ> convert rfc822-to-8bit; Mon, 2 Sep 2002 23:35:25 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Memory issues with 2.4.19+
Date: Mon, 2 Sep 2002 23:42:40 -0400
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200209022342.40952.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.100.232.94] using ID <shawn.starr@rogers.com> at Mon, 2 Sep 2002 23:39:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is normal but:

when using vmstat 1  in single user mode free memory drops while cpu is 100% 
idle. When using top the memory drops and buffered memory inreases. When I 
quit top and go back to vmstat the same memory stats are shown.  Will the 
kernel free this so called used memory back or is the buffered memory still 
usable by the system?

I'm not show how Linux's VM works with memory usage.

Shawn.

