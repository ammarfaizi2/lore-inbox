Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313995AbSDKFzA>; Thu, 11 Apr 2002 01:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313996AbSDKFy7>; Thu, 11 Apr 2002 01:54:59 -0400
Received: from f38.pav0.hotmail.com ([64.4.32.222]:3078 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S313995AbSDKFy6>;
	Thu, 11 Apr 2002 01:54:58 -0400
X-Originating-IP: [202.88.225.32]
From: "blesson paul" <blessonpaul@msn.com>
To: linux-kernel@vger.kernel.org
Subject: put_user_byte()
Date: Thu, 11 Apr 2002 11:24:52 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F38uSbh29cM3oryKFRJ00031d09@hotmail.com>
X-OriginalArrivalTime: 11 Apr 2002 05:54:52.0812 (UTC) FILETIME=[6634C4C0:01C1E11D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
                I need to copy some data from kernel memory space to user 
memory space. When I investigated, the command for that purpose is 
put_user_byte(). But in kernel2.4, I can't find the implementation of this 
command. I want to know the command which replaced put_user_byte() in 2.4 
kernel. Also I want to know whether there is any synonyms for verify_area() 
in kernel 2.4
regards
Blesson Paul



_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

