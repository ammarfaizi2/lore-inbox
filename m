Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSBKP7O>; Mon, 11 Feb 2002 10:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289832AbSBKP7E>; Mon, 11 Feb 2002 10:59:04 -0500
Received: from f207.law11.hotmail.com ([64.4.17.207]:1290 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S289829AbSBKP6y>;
	Mon, 11 Feb 2002 10:58:54 -0500
X-Originating-IP: [129.237.125.187]
From: "Akarapu Mahesh" <mahesh_a6@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: doubt About large socket buffers on 2.4 kernels
Date: Mon, 11 Feb 2002 15:58:48 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F207mVFOh1vdkmyCF1H000024bf@hotmail.com>
X-OriginalArrivalTime: 11 Feb 2002 15:58:48.0895 (UTC) FILETIME=[FE38FCF0:01C1B314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I am using 2.4.9-13 kernel. I want to use large socket buffers .I set 
maximum values for /proc/sys/net/core/rmem_max and 
/proc/sys/net/core/wmem_max and also made sure the maximum value is high for 
/proc/sys/net/ipv4/tcp_wmem and /proc/sys/net/ipv4/tcp_rmem. But when i run 
some ttcp tests i observe that the advertised window of the receiver starts 
from 5792 bytes even though i use large windows.I read that 2.4 kernels do 
auto-tuning. Is there anyway i can make the advertised windows larger than 
5792 . OR please suggest some resources where i can find the information 
about the socket buffer implementations. I need this information very much

Awaiting a reply from some of you.

Thanks
Mahesh


_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

