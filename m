Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313413AbSDLH03>; Fri, 12 Apr 2002 03:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313414AbSDLH03>; Fri, 12 Apr 2002 03:26:29 -0400
Received: from spielberg.vip.uk.com ([194.176.218.9]:8913 "EHLO
	spielberg.vip.uk.com") by vger.kernel.org with ESMTP
	id <S313413AbSDLH02>; Fri, 12 Apr 2002 03:26:28 -0400
From: "Rowan Ingvar Wilson" <rowan.ingvar.wilson@0800dial.com>
To: "'Frank Schaefer'" <frank.schafer@setuza.cz>,
        <linux-kernel@vger.kernel.org>
Subject: RE: /dev/zero
Date: Fri, 12 Apr 2002 08:26:22 +0100
Message-ID: <002c01c1e1f3$5bf7e600$c82d3c3e@m3v0u8>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <1018595942.2918.2.camel@ADMIN>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a matter of interest myself...what is it's actual function? It
is used during kernel debugging to supply an input?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Frank Schaefer
Sent: 12 April 2002 08:19
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/zero

On Fri, 2002-04-12 at 08:46, blesson paul wrote:
> Hi all
>                I am newbie to linux kernel. What is the use of
/dev/zero. 
> Why it is created and how to use it
> regards
> Blesson Paul
> 
> 
> 
> _________________________________________________________________
> Chat with friends online, try MSN Messenger: http://messenger.msn.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hi,

/dev/zero is a data source. It delivers zeroes ( maybe that's why this
name ;-).

BTW: You are new to the linux kernel or new to linux / unix?

Regards
Frank

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

