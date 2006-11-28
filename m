Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757928AbWK1MLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbWK1MLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757931AbWK1MLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:11:17 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:59891
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1757928AbWK1MLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:11:16 -0500
Message-ID: <007501c712e7$7a418c90$2900a8c0@arecakevin>
From: "Areca Support" <support@areca.com.tw>
To: "erich" <erich@areca.com.tw>, "Bron Gondwana" <brong@fastmail.fm>
Cc: <linux-kernel@vger.kernel.org>, "Maurice Volaski" <mvolaski@aecom.yu.edu>
References: <a06240400c18e4b03eadf@[129.98.90.227]> <00f501c711d4$f04c7530$b100a8c0@erich2003> <20061127130518.GC7610@brong.net>
Subject: Re: Pathetic write performance from Areca PCIe cards
Date: Tue, 28 Nov 2006 20:19:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-OriginalArrivalTime: 28 Nov 2006 12:01:06.0812 (UTC) FILETIME=[E2AC13C0:01C712E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

This is Kevin Wang from Areca Technology, Tech-Support Team.
as you recommend, we will updated driver/firmware to our ftp/website once it
released.

the firmware V1.42 sent by erich is a beta version and not released yet, it
is certifying still.
so you can not find it in our ftp site or website now.

and could you please inform me more detail about the two releases V1.41 ?
as i remember, the V1.41 should released once only, a second V1.41 could be
a bug fixed version and a bug fixed version should not public for customer
download. please inform me more detail about it, i will ask ftp releated
person check it.
sorry for the inconvenience.


Best Regards,


Kevin Wang

Areca Technology Tech-support Division
Tel : 886-2-87974060 Ext. 223
Fax : 886-2-87975970
Http://www.areca.com.tw
Ftp://ftp.areca.com.tw

----- Original Message ----- 
From: "Bron Gondwana" <brong@fastmail.fm>
To: "erich" <erich@areca.com.tw>
Cc: "Maurice Volaski" <mvolaski@aecom.yu.edu>; "å»£å®‰ç§‘æŠ€ è˜‡èŽ‰åµ"
<lusa@areca.com.tw>; "å»£å®‰ç§‘æŠ€ ç¾…ä»»å‰" <robert.lo@areca.com.tw>;
"å»£å®‰ç§‘æŠ€ çŽ‹å®¶ä»²" <kevin34@areca.com.tw>; <support@areca.com.tw>;
<linux-kernel@vger.kernel.org>
Sent: Monday, November 27, 2006 9:05 PM
Subject: Re: Pathetic write performance from Areca PCIe cards


> On Mon, Nov 27, 2006 at 11:34:23AM +0800, erich wrote:
> > Dear Maurice Volaski,
> >
> > Please update Areca Firmware version into 1.42.
> > Areca's firmware team found some problems on high capacity transfer.
> > Hope the weird  phenomenon should disappear.
>
> Erich, is there anyone at Areca that you can pass on the message to
>
>        +--------------------------------------------+
>        | Please update your ftp server/website when |
>        | there is a new firmware or driver release! |
>        +--------------------------------------------+
>
> that would be great.  I followed the links from www.areca.us to the
> firmware at:
>
> ftp://ftp.areca.com.tw/RaidCards/BIOS_Firmware/ARC1130/
>
> for our cards, but the 1210 and 1220 that Maurice was speaking about
> suffer from the same problem - there is no mention of a 1.42 firmware
> anywhere, just the 1.41 that's been out for ages.
>
> ...
>
>
> And speaking of 1.41, there appear to have been two releases on two
> different dates both called 1.41, as well as two different versions
> of the driver that both call themselves version 1.41 despite the
> second one fixing a major bug we suffered from.
>
> Please also avoid that behaviour and label each new version of
> the driver with a new number if you're using version numbers.
>
> Numbers are cheap, but identifying if a machine is running the patches
> it needs to not crash every few weeks under the loads we run them at
> is not (well, not until it crashes anyway!)
>
>
> Thanks for listening, and hopefully thanks in advance for making your
> drivers and firmware easier to find and identify in future.
>
> Regards,
>
> Bron.

