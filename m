Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTCYEXg>; Mon, 24 Mar 2003 23:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbTCYEXg>; Mon, 24 Mar 2003 23:23:36 -0500
Received: from f111.pav2.hotmail.com ([64.4.37.111]:56580 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261447AbTCYEXe>;
	Mon, 24 Mar 2003 23:23:34 -0500
X-Originating-IP: [202.54.64.9]
X-Originating-Email: [senthil_gowran@hotmail.com]
From: "Senthil Kumar" <senthil_gowran@hotmail.com>
To: linux-kernel@vger.kernel.org, majordomo@vger.kernel.org
Subject: Please send a reply to me....
Date: Tue, 25 Mar 2003 04:34:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F111KV6aGHW5uUJvf5w0000e9f0@hotmail.com>
X-OriginalArrivalTime: 25 Mar 2003 04:34:38.0288 (UTC) FILETIME=[D847B500:01C2F287]
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
Get ball by ball action on your desktop. 
http://server1.msn.co.in/msnspecials/cricketdownload/contest.asp Get Hutch 
MSN Cricketer

