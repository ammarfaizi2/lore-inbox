Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268985AbTBWVmA>; Sun, 23 Feb 2003 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268987AbTBWVmA>; Sun, 23 Feb 2003 16:42:00 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:59549 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S268985AbTBWVl7>; Sun, 23 Feb 2003 16:41:59 -0500
Message-ID: <3E59426D.2070708@bogonomicon.net>
Date: Sun, 23 Feb 2003 15:51:41 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-1?Q?Toplica_Tanaskovic=27?= <toptan@EUnet.yu>,
       Sheng Long Gradilla <skamoelf@netscape.net>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu> <200302231921.27024.toptan@EUnet.yu> <3E59299B.8090200@netscape.net> <200302232136.09903.toptan@EUnet.yu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Thank God, it's not agpgart's fault, it is the fact that Dave Jones mentioned 
> earlier, I doubdt that any (ATI, nVidia..) drivers support AGP8x transfer 
> rate.

The nVidia 1.0-4191 kernel driver release notes say they now support AGP 
8X (AGP 3.0).  I did notice a slight speed up on some very heavy 
graphics tasks but that is it.

- Bryan

