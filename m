Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312920AbSDOQU1>; Mon, 15 Apr 2002 12:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSDOQU0>; Mon, 15 Apr 2002 12:20:26 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:19866 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S312920AbSDOQUY>; Mon, 15 Apr 2002 12:20:24 -0400
Date: Mon, 15 Apr 2002 18:20:11 +0200 (CEST)
From: Michael De Nil <michael@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Stolen Memory <- i830M video chip
In-Reply-To: <Pine.LNX.4.44.0204112244480.4745-100000@LiSa>
Message-ID: <Pine.LNX.4.44.0204151818590.22422-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Michael De Nil wrote:

> hey
>
>
> working here on an Asus L1-laptop which contains the Intel 830M graphical
> chip. when loading the agpgart module, it prints in syslog that there is
> only 1 Meg 'stolen ram'. like that, it's not possable to run X @ 1024x768
> with more then 256 colors.


Asus will take care of this, recieved following mail:



>Date: Mon, 15 Apr 2002 20:40:21 +0800
>From: tsd <tsd@asus.com.tw>
>To: michael@aerythmic.be
>Subject: Re:Asus L1-serie notebook -> i830M chipset
>
>
>Dear Sir
>We will try our best to release the new bios which can fix this bug , and
>you
>can install linux successfully...
>but you still need to wait for the latest bios release...
>Thank You


Michael


-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
       Linux LiSa 2.4.18 #4 SMP ma apr 1 11:11:48 CEST 2002 i686
      18:18:01 up 22:31,  1 user,  load average: 0.00, 0.00, 0.00
-----------------------------------------------------------------------

