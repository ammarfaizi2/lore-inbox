Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDXX1L>; Tue, 24 Apr 2001 19:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDXX1B>; Tue, 24 Apr 2001 19:27:01 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:61427 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S132686AbRDXX0u>; Tue, 24 Apr 2001 19:26:50 -0400
Message-ID: <3AE60A3D.9090103@holly-springs.nc.us>
Date: Tue, 24 Apr 2001 19:20:29 -0400
From: Michael Rothwell <rothwell@holly-springs.nc.us>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.19 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: #define HZ 1024 -- negative effects?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any negative effects of editing include/asm/param.h to change 
HZ from 100 to 1024? Or any other number? This has been suggested as a 
way to improve the responsiveness of the GUI on a Linux system. Does it 
throw off anything else, like serial port timing, etc.?

