Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283343AbRK2R2V>; Thu, 29 Nov 2001 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283339AbRK2R2L>; Thu, 29 Nov 2001 12:28:11 -0500
Received: from f56.law3.hotmail.com ([209.185.241.56]:2823 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S283337AbRK2R1z>;
	Thu, 29 Nov 2001 12:27:55 -0500
X-Originating-IP: [63.122.122.73]
From: "Xiaozhou Qiu" <xzqiu@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to communicate between kernel and user space?
Date: Thu, 29 Nov 2001 17:27:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F56sjUHQHh2wLCVYl4m0000010f@hotmail.com>
X-OriginalArrivalTime: 29 Nov 2001 17:27:49.0401 (UTC) FILETIME=[2AD80890:01C178FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry if this is a newbie's question. I am developing a kernel module 
which needs to call some crypt functions implemented in user space. Since 
those functions utilize openssl library, I assume there is no easy way to 
port them into kernel.

I wonder whether there is an easy and elegant way to call the user space 
functions from the kernel and get the results, if /proc can not be used.  If 
anybody knows where I can find a crypt library in the kernel, that will be a 
great help too.

Thank you very much.

Xiaozhou Qiu


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

