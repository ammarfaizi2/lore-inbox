Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSE3Ije>; Thu, 30 May 2002 04:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSE3Ijd>; Thu, 30 May 2002 04:39:33 -0400
Received: from blue.gradwell.net ([195.149.39.10]:15251 "HELO
	blue.gradwell.net") by vger.kernel.org with SMTP id <S316491AbSE3Ijd>;
	Thu, 30 May 2002 04:39:33 -0400
Message-ID: <3CF5E6E8.40509@dcrdev.demon.co.uk>
Date: Thu, 30 May 2002 09:46:32 +0100
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI - docos/where to start?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a new laptop here with a chipset that isn't currently properly 
identified/configured by linux (it's Intel 845MP based - specifically, 
Linux doesn't recognise the ISA bridge component which controls sound 
card etc.).

I'd like to fix this up myself so I was wondering if someone could give 
me some pointers to bits of kernel code/documentation I should be 
looking at before undertaking this work?

Thanks,

Dan.


