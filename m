Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSE3Sh2>; Thu, 30 May 2002 14:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSE3Sh1>; Thu, 30 May 2002 14:37:27 -0400
Received: from pool-151-196-236-146.balt.east.verizon.net ([151.196.236.146]:61863
	"EHLO starbug.reddwarf") by vger.kernel.org with ESMTP
	id <S316799AbSE3Sh1>; Thu, 30 May 2002 14:37:27 -0400
Message-ID: <3CF6723E.3020502@dlister.net>
Date: Thu, 30 May 2002 14:41:02 -0400
From: Brian Davids <dlister@dlister.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Michail Rusinov <one@da.ru>
Subject: Re: PROBLEM: NVidia drivers with 2.5 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > Is there any method to compile NVidia drivers with linux kernel
  > 2.5.18?
  > When I begin to compile them, they write
  > "error This driver does not support 2.5.x development kernels!"
  > Is there any solution to make it work?


There was a patch to nVidia's v.2880 drivers tested on kernel 2.5.15
posted on May 13 which you can find here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/1034.html



Brian Davids

