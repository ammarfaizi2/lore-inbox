Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTA3KsP>; Thu, 30 Jan 2003 05:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbTA3KsP>; Thu, 30 Jan 2003 05:48:15 -0500
Received: from mail1.ugr.es ([150.214.20.24]:61624 "EHLO mail1.ugr.es")
	by vger.kernel.org with ESMTP id <S267478AbTA3KsO>;
	Thu, 30 Jan 2003 05:48:14 -0500
Message-ID: <3E39052F.3060903@ugr.es>
Date: Thu, 30 Jan 2003 11:57:51 +0100
From: Miguel Lastra <mlastral@ugr.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: data corruption on 845PE ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I am experiencing some IDE problems with a Abit IT7 MAX2 V2.0 
motherboard. It's chipset is intel 845PE . I installed the Suse 8.0 
distribution (2.4.18 kernel) and it did no recognize the IDE controler 
(so no dma).

  I have tried with 2.4.20 and 2.4.21-pre4 kernels (stock kernels form 
kernel.org) and with both a get ide-dma errors after a while reported 
when using e2fsck (on my Ext3 filesystems).

Is there any data corruption issue with the intel 845PE chipset ?

Thanks in advance


    Miguel



