Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRCELHb>; Mon, 5 Mar 2001 06:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRCELHV>; Mon, 5 Mar 2001 06:07:21 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:61722 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129166AbRCELHQ>; Mon, 5 Mar 2001 06:07:16 -0500
Message-ID: <001401c0a564$47747120$3201a8c0@laptop>
From: "Christian Hilgers" <webmaster@server-side.de>
To: "Markus Pfeiffer" <profmakx@profmakx.de>, <davidge@jazzfree.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0103041745210.1038-100000@roku.redroom.com> <002d01c0a4e4$c9e2da00$0201a8c0@fmp>
Subject: Re: DVD Problem
Date: Mon, 5 Mar 2001 12:06:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Von: Markus Pfeiffer <profmakx@profmakx.de>
An: <davidge@jazzfree.com>; Christian Hilgers <webmaster@server-side.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>


>> On Sun, 4 Mar 2001, Christian Hilgers wrote:
>>
>> So you need to compile the kernel with UDF support , which is the
>> filesystem used in DVDs. As you said, iso9660 works, but only for the
>> first 650 mb. And after it take a look at www.linuxvideo.org and
>> www.videolan.org.
>
>Won´t work. UDF is a fs of its own. I think there´s something wrong
with ide
>(DVD or controller or BIOS ) which reports wrong device size ...

I tried Kernel 2.4.0, this one is also working fine. Than I used the
same .config for the 2.4.1 Kernel.
And the DVD did't work!!
Maybe a bug in the CD-Rom driver?
I think I will try the 2.4.2 Kernel.

Christian

