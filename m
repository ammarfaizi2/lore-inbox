Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSDVJSK>; Mon, 22 Apr 2002 05:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSDVJSJ>; Mon, 22 Apr 2002 05:18:09 -0400
Received: from f38.pav0.hotmail.com ([64.4.32.222]:20499 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S314095AbSDVJSJ>;
	Mon, 22 Apr 2002 05:18:09 -0400
X-Originating-IP: [202.88.227.113]
From: "blesson paul" <blessonpaul@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Loading a new charecter device
Date: Mon, 22 Apr 2002 14:48:03 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F38VH96co9NOSvW81Z200014e47@hotmail.com>
X-OriginalArrivalTime: 22 Apr 2002 09:18:03.0595 (UTC) FILETIME=[9B05E1B0:01C1E9DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
		I wrote a driver  for a new charecter device and put the major number as 
200. Then I created  a new device say 'XYZ' by the following command
mknod m=rw XYZ c 200 0. I didn't specified the minor value in the program. I 
given the minor value as 0 when I made the device. But I think it will not 
make any problems. Still my driver is not working.  When I try to open the 
device, it will return no such device. How to know whether the device driver 
has loaded perfectly. What is the problem. Please somebody help me.
regards
Blesson Paul



_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

