Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSFESsI>; Wed, 5 Jun 2002 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFESsH>; Wed, 5 Jun 2002 14:48:07 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:40385 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id <S315883AbSFESsG>; Wed, 5 Jun 2002 14:48:06 -0400
Date: Wed, 05 Jun 2002 21:47:44 +0200
From: Boris Kimelman <erwin138@netvision.net.il>
Subject: pctel modem bug
To: linux-kernel@vger.kernel.org
Message-id: <3CFE6AE0.2000600@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0rc2)
 Gecko/20020512 Netscape/7.0b1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
you probably know about this but i'll tell you anyway. there is a bug 
related to pctel modems. a very nice person made drivers for linux of 
this modems and they can work on linux. the problem is that when the 
modem finally dials after all the configuration, it puts out a "no 
carrier" message and disconnects. please handle the problem and if it 
was already fixed please reply to me and say which kernel i should download.

    Thank you, Boris Kimelman.

