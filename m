Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273857AbRJIJ0E>; Tue, 9 Oct 2001 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRJIJZy>; Tue, 9 Oct 2001 05:25:54 -0400
Received: from [195.66.192.167] ([195.66.192.167]:51471 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273857AbRJIJZp>; Tue, 9 Oct 2001 05:25:45 -0400
Date: Tue, 9 Oct 2001 12:25:32 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6898820256.20011009122532@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re:
In-Reply-To: <20011002153002.15494.qmail@mailweb16.rediffmail.com>
In-Reply-To: <20011002153002.15494.qmail@mailweb16.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dinesh,

Tuesday, October 02, 2001, 5:30:02 PM, you wrote:


DG> Hello,
DG> I have written a linux kernel module. The linux version is 2.2.14. 
DG> In this module I have declared an array of size 2048. If I use this array, the execution of this module function causes kernel to reboot. If I kmalloc() this array then execution of this module
DG> function doesnot cause any problem.
DG> Can you explain this behaviour?
DG> Thnaks,
DG> Dinesh 
 

DG> -
DG> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
DG> the body of a message to majordomo@vger.kernel.org
DG> More majordomo info at  http://vger.kernel.org/majordomo-info.html
DG> Please read the FAQ at  http://www.tux.org/lkml/


stack overflow

-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


