Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRDUSYv>; Sat, 21 Apr 2001 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132810AbRDUSYm>; Sat, 21 Apr 2001 14:24:42 -0400
Received: from mail.axisinc.com ([193.13.178.2]:14098 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S132807AbRDUSY2>;
	Sat, 21 Apr 2001 14:24:28 -0400
From: johan.adolfsson@axis.com
Message-ID: <00db01c0ca90$94b0f3e0$b7b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Cc: <esr@thyrsus.com>, <elenstev@mesatop.com>,
        "Bjorn Wesen" <bjorn.wesen@axis.com>
In-Reply-To: <01042107554400.01451@localhost.localdomain>
Subject: Re: 2.4.3-ac11 request for help texts for recenty introduced config options
Date: Sat, 21 Apr 2001 20:26:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed most of the CONFIG_ETRAX stuff,
many of them are not visible in CML1... (at least not with menuconfig)
some of the LED stuff should probably not even be there.
Björn can probably submit a patch within a few days.

/Johan

----- Original Message -----
From: Steven Cole <elenstev@mesatop.com>
To: <linux-kernel@vger.kernel.org>
Cc: <esr@thyrsus.com>; <elenstev@mesatop.com>
Sent: Saturday, April 21, 2001 3:55 PM
Subject: 2.4.3-ac11 request for help texts for recenty introduced config
options


> As of kernel 2.4.3-ac11, there are 464 config options which have no help
text in Configure.help.
>
> Here is the list of these items which have been introduced  after
2.4.3-ac1.
> Each group is incremental, versus 2.4.3-ac[n-1].
>
> If you see one of your options here, please consider generating a patch
for Configure.help,
> or send me the information and I'll do the rest.
>
> A status of "acknowledged" means that the item is being worked on by the
person named or
> their designate.  Thank you to the maintainers who have responded.
>
> Thanks in advance,
> Steven


