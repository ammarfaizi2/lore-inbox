Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbTC1Syl>; Fri, 28 Mar 2003 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbTC1Syk>; Fri, 28 Mar 2003 13:54:40 -0500
Received: from ccnetbkup.hku.hk ([147.8.2.96]:59813 "EHLO mail2.hku.hk")
	by vger.kernel.org with ESMTP id <S263096AbTC1Syj>;
	Fri, 28 Mar 2003 13:54:39 -0500
Message-ID: <016001c2f55c$ee6380d0$18f90893@george804>
From: "George Chang" <h9916628@hkusua.hku.hk>
To: "Hemanshu Kanji Bhadra, Noida" <hemanshub@noida.hcltech.com>,
       <linux-kernel@vger.kernel.org>
References: <E04CF3F88ACBD5119EFE00508BBB2121086322CA@exch-01.noida.hcltech.com>
Subject: Re: Read and write by a module
Date: Sat, 29 Mar 2003 03:04:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thanks hemanshu. You are very nice

Could I copy the file /proc/ to harddisk? I hope I can directly write the
data to the harddisk as I am working on logging system. I am writing a
function performing like printk , but it directs the event messages to a
specific disk location e.g. /usr/log/sys.log.


Thanks


George

EEE HKU


----- Original Message -----
From: "Hemanshu Kanji Bhadra, Noida" <hemanshub@noida.hcltech.com>
To: "h9916628" <h9916628@hkusua.hku.hk>
Sent: Friday, March 28, 2003 8:01 PM
Subject: RE: Read and write by a module


> Hi,
>
> have you gone thr'u proc_fs guide..
>
> It may help as it contains some help regarding reading and writing in
> kernel.
>
> - hemanshu
>
> -----Original Message-----
> From: h9916628 [mailto:h9916628@hkusua.hku.hk]
> Sent: Thursday, March 27, 2003 7:14 PM
> To: linux-kernel@vger.kernel.org
> Subject: Read and write by a module
> Importance: High
>
>
> Dear all,
>
> Please help! I have to read and write cotents from a file by a module.
Could
>
> anyone tell me the procedures or advise me? This is very urgent to me.
> Thanks
>
> I am working on the platform of Rad Hat 7.3 Kernel version 2.4-18
>
> Thanks
>
> George Chang Tak Yin
> EEE HKU
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


