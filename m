Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUKNSoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUKNSoP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUKNSoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:44:15 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:3122 "EHLO
	mwinf0812.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261331AbUKNSoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:44:13 -0500
Message-ID: <4197A7CB.1030904@wanadoo.fr>
Date: Sun, 14 Nov 2004 19:45:31 +0100
From: mahashakti89 <mahashakti89@wanadoo.fr>
Reply-To: mahashakti89@wanadoo.fr
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr, en-us, de-de
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscontrol activation = problem on boot
References: <4197977B.5080400@wanadoo.fr> <Pine.LNX.4.53.0411141846150.20107@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411141846150.20107@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt a écrit :
>> Nov 12 19:15:13 ishwara kernel: hdb: read_intr: status=0x59 {
>>DriveReady SeekComplete DataRequest Error }
>>
>>>Nov 12 19:15:13 ishwara kernel: hdb: read_intr: error=0x04 {
>>
>>DriveStatusError }
>>
>>>Nov 12 19:15:13 ishwara kernel: ide: failed opcode was: unknown
>>>Nov 12 19:15:13 ishwara kernel: end_request: I/O error, dev hdb,
>>
>>sector 78172098
>>
>>>Nov 12 19:15:13 ishwara kernel: Buffer I/O error on device hdb5,
>>
>>logical block 61785735
> 
> 
> Looks like an old harddisk that does not understand an IDE command.
> 
> 
>>it can last two or three minutes and then I have accsess to my
>>Gnome Desktop.
> 
> 
> Do you think that's normal? I can come up in less than 60 secs. (80x25), so I
> presume boting X does not take much more time than 3 minutes.
> What do you mean by "last"? 

It lasts for two or three minutes  -sorry my english ...
Does the error message stay there and the box is
> like, idle? No other stuff scrolling through?

Its scrolling the same message for two minutes and what I have posted is 
the end of the message, then I am logging into X.
