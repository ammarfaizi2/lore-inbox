Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDXH4I>; Wed, 24 Apr 2002 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSDXH4H>; Wed, 24 Apr 2002 03:56:07 -0400
Received: from [159.226.41.188] ([159.226.41.188]:65031 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S290818AbSDXH4G>; Wed, 24 Apr 2002 03:56:06 -0400
Date: Wed, 24 Apr 2002 15:55:25 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE2716BF.AAAE8A@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all.
  My cluster go wrong these days. So many times when I "/sbin/reboot" a node, the following message will be displayed on the console.

>INIT: Switching to runlevel: 6
>INIT: Send processes the TERM signal
>Unable to handle kernel NULL pointer dereference
  
  What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
  Thank you in advance 8-)
  
            Zhigang Huo
            zghuo@ncic.ac.cn

