Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbRFPOOs>; Sat, 16 Jun 2001 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbRFPOOj>; Sat, 16 Jun 2001 10:14:39 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:41008 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264630AbRFPOOY>; Sat, 16 Jun 2001 10:14:24 -0400
Message-ID: <002201c0f66e$90675360$3303a8c0@einstein>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Thomas Molina" <tmolina@home.com>,
        "Rachel Greenham" <rachel@linuxgrrls.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106160827100.13727-100000@localhost.localdomain>
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
Date: Sat, 16 Jun 2001 16:13:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm certainly willing to provide any data it's decided is necessary to
> collect to make the correlations.  I'll even volunteer to be the
.
> bit different - I have the hard drive on the promise interface (ide2) and

If possible, can you remove the hard disc from the promise and attach it on
the VIA-Controller and test if the problem still occurs? (prepare a bootdisc
if you cannot boot. Propably, you have to pass a new root-partition to the
kernel)
I hardly believe that the promise controller has some problems with the new
VIA setup introduced in 2.4.3-ac7. Using the promise ports of the A7V133 is
the only correlation I see again and again...

--
PS: Sorry for using outlook, but sometimes you use an computer you doesn´t
own. :-)

