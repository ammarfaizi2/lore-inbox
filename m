Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbTCKDwm>; Mon, 10 Mar 2003 22:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCKDwm>; Mon, 10 Mar 2003 22:52:42 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:17419
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S262803AbTCKDwl>; Mon, 10 Mar 2003 22:52:41 -0500
Message-ID: <3E6D5FDB.6000306@rackable.com>
Date: Mon, 10 Mar 2003 20:02:35 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: herbert@13thfloor.at
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre5 adaptec updates ...
References: <20030310234428.GB31279@www.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2003 04:03:18.0470 (UTC) FILETIME=[2609BE60:01C2E783]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>updated the linux-2.4.21-pre5 aic7xxx driver
>and added aic79xx U320 driver support from
>adaptec source code.
>
>aic7xxx version 6.2.10 (adaptec)
>aic79xx version 1.1.0 (adaptec)
>
>patch can be downloaded from
>http://www.13thfloor.at/Patches/
>
>please CC any replies to me personally, because
>I'm not subscribed to lkml.
>
>  
>
  Hopefully 2.4.21 will pickup the aic79xx updates from the ac tree. 
 Otherwise this is going to cause a lot of noise on the list.  Both tyan 
and intel switched to the aic79xx  for their Xeon 533 FSB motherboard 
refreshes.  I'd bet that many of the other mobo mfg are doing the same.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



