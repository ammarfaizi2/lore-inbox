Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRJHCn4>; Sun, 7 Oct 2001 22:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRJHCnq>; Sun, 7 Oct 2001 22:43:46 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:53230 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S271667AbRJHCnj>; Sun, 7 Oct 2001 22:43:39 -0400
Message-ID: <3BC111A7.6050407@langhorst.com>
Date: Sun, 07 Oct 2001 22:38:31 -0400
From: Brad Langhorst <brad@langhorst.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010916
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual pdc20268(ultra100tx2) hangs kernel 2.4.9,10 on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've resolved this problem - it turns out by disabling the modem on the 
motherboard eliminates the problem.

The problem is not a result of resource starvation, since disabling 
other devices like USB or the on board sound have no effect.


brad

