Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSK2LHn>; Fri, 29 Nov 2002 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSK2LHm>; Fri, 29 Nov 2002 06:07:42 -0500
Received: from f136.pav2.hotmail.com ([64.4.37.136]:29707 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267011AbSK2LHl>;
	Fri, 29 Nov 2002 06:07:41 -0500
X-Originating-IP: [202.140.142.131]
From: "Parthiban M" <parthi_m@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: pamanick@npd.hcltech.com
Subject: Memory leak trace utility for kernel module !
Date: Fri, 29 Nov 2002 16:44:58 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F136CASlDxzcIZChJhX0001c50a@hotmail.com>
X-OriginalArrivalTime: 29 Nov 2002 11:14:58.0504 (UTC) FILETIME=[8D86CC80:01C29798]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

      I've implemented linux kernel modules "for IP storage " using 
kernel(2.4.18-3)
socket's and sending/receiving data of size more than MBs. I'm iteratively 
doing
copy operation to remote machine after 15 hours my machine running out of 
memory, seems to be memory leak in my driver.

plz let me know any memory trace utility available for linux 
kernel(2.4.18-3) or any
info. regarding my problem.

Thx,
Parthi.

Note : haven't enabled kernel preemption patch in my running kernel.



_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

