Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130480AbRCDSNj>; Sun, 4 Mar 2001 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRCDSNb>; Sun, 4 Mar 2001 13:13:31 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:12918 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130480AbRCDSNX>; Sun, 4 Mar 2001 13:13:23 -0500
Message-ID: <002101c0a4d6$afa5a900$3201a8c0@laptop>
From: "Christian Hilgers" <webmaster@server-side.de>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Cc: <davidge@jazzfree.com>
In-Reply-To: <Pine.LNX.4.21.0103041745210.1038-100000@roku.redroom.com>
Subject: Re: DVD Problem
Date: Sun, 4 Mar 2001 19:12:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Von: <davidge@jazzfree.com>
>

>On Sun, 4 Mar 2001, Christian Hilgers wrote:
>
>So you need to compile the kernel with UDF support , which is the
>filesystem used in DVDs. As you said, iso9660 works, but only for the
>first 650 mb. And after it take a look at www.linuxvideo.org and
>www.videolan.org.

UDF was the first I tried, but it didn't work.

Christian

>> Hi,
>>
>> I'm trying to use the 2.4.1 Kernel but I have some troubles with my
>> ATAPI Matsushita UJDA510 DVD (Intel 82371AB/EP PCI Bus Master IDE
>> Controler).
>> It works perfekt with CD-Rom but when I try to read a ISO 9660 DVD I
got
>> an error.
>>
>> I can mount the DVD and I can list the complet content but I guess I
>> can't access any File behind 650 MB.




