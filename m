Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262356AbSJKELq>; Fri, 11 Oct 2002 00:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJKELq>; Fri, 11 Oct 2002 00:11:46 -0400
Received: from f44.pav2.hotmail.com ([64.4.37.44]:31757 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262351AbSJKELl>;
	Fri, 11 Oct 2002 00:11:41 -0400
X-Originating-IP: [202.140.142.131]
From: "Parthiban M" <parthi_m@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-net@vger.kernel.org
Cc: pamanick@npd.hcltech.com
Subject: Query reg. free and sysinfo structure !
Date: Fri, 11 Oct 2002 09:47:20 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F44WSUOIFLkkPFoffSC00013b73@hotmail.com>
X-OriginalArrivalTime: 11 Oct 2002 04:17:20.0882 (UTC) FILETIME=[17C75D20:01C270DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

     I've implemented linux kernel modules "for IP storage" using kernel 
socket's and sending/receiving data of size more than one MB. During socket 
operations free command shows 4k leak constantly and after some time it's 
maintaining 2MB in free memory column continuously. pls. let me know any 
memtrace utility available for kernel(2.4.18-3) or solution for my problem.


thanks,
parthi


--
www.hcltechnologies.com

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

