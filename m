Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbREQMjo>; Thu, 17 May 2001 08:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbREQMje>; Thu, 17 May 2001 08:39:34 -0400
Received: from mail.xmission.com ([198.60.22.22]:25873 "EHLO mail.xmission.com")
	by vger.kernel.org with ESMTP id <S261411AbREQMj3>;
	Thu, 17 May 2001 08:39:29 -0400
Message-ID: <3B03C763.1080407@xmission.com>
Date: Thu, 17 May 2001 06:43:15 -0600
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre3 i686; en-US; rv:0.9+) Gecko/20010514
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8139too and 2.4.5-pre3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik:

On kernel boot from messages I'm getting a different report from my 
RealTek 8139:

May 17 06:33:32 f1j kernel: eth0: RealTek RTL8139 Fast Ethernet at 
0xd0862000, 00:50:ba:d8:2c:35, IRQ 5
May 17 06:33:32 f1j kernel: eth0: media is unconnected, link down, or 
incompatible connection

Used to report on the second line: "half duplex or full duplex mode 
detected"

