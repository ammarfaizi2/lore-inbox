Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSGHWTU>; Mon, 8 Jul 2002 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSGHWTT>; Mon, 8 Jul 2002 18:19:19 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:53414 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317191AbSGHWTT>; Mon, 8 Jul 2002 18:19:19 -0400
Message-ID: <3D29D540.3080001@mindspring.com>
Date: Mon, 08 Jul 2002 18:09:04 +0000
From: Andy <ahaning@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI + cdwriter problem
References: <200207082159.WAA03443@darkstar.example.net> <006101c226ca$d0c9a380$0501a8c0@Stev.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> its a Benq 32x10x40 CD/RW
Check here for your drive to see if there are any updates for it: 
http://perso.club-internet.fr/farzeno/firmware/cdr/cdrf.htm

> running with the Promise ATA/133 controller
If the drive is not ATA/### where ### is 66/100/133, then you may try 
putting the drive on a UDMA/33 port to see if that helps at all. (So you 
could eliminate the ATA/133 port as being part of the problem.

Andy

