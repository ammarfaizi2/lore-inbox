Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264212AbTCXN6J>; Mon, 24 Mar 2003 08:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbTCXN6I>; Mon, 24 Mar 2003 08:58:08 -0500
Received: from f18.pav2.hotmail.com ([64.4.37.18]:62480 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264212AbTCXN6I>;
	Mon, 24 Mar 2003 08:58:08 -0500
X-Originating-IP: [202.140.142.131]
X-Originating-Email: [senthil_gowran@hotmail.com]
From: "Senthil Kumar" <senthil_gowran@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2003 14:09:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F18ZceUkBtmTpRM1J2Y00013f83@hotmail.com>
X-OriginalArrivalTime: 24 Mar 2003 14:09:11.0115 (UTC) FILETIME=[F145E9B0:01C2F20E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear All,

   Please give me some idea to play the extracted data from mp3 in real time 
application.
i. e. From the mp3 file i extracted the data to be played alone to my local 
buffer leaving the Frame information of 32 bits.

Then through ioctl() function i wrote the channel, bitrate and Format.
Then through write function i wrote the data captured in the local buffer to 
the dsp device /dev/dsp.
But i am getting only the irregular noise.

Is any uncompression should be done for data and written.
Is so how the uncompression should be done..
with thanks and regards
Senthil




_________________________________________________________________
Cricket World Cup 2003 http://server1.msn.co.in/msnspecials/worldcup03/ 
News, Views and Match Reports.

