Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280653AbRKNP3a>; Wed, 14 Nov 2001 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280660AbRKNP31>; Wed, 14 Nov 2001 10:29:27 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:51214 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280653AbRKNP3B> convert rfc822-to-8bit; Wed, 14 Nov 2001 10:29:01 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andreas Boman <aboman@nerdfest.org>, arjanv@redhat.com
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Date: Wed, 14 Nov 2001 16:28:24 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney> <3BF285D7.8F5AAB6E@redhat.com> <20011114101347.272f6b88.aboman@nerdfest.org>
In-Reply-To: <20011114101347.272f6b88.aboman@nerdfest.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E1641xs-0000se-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ehm you know that XP cpu's don't support SMP configuration ?
>
> _Officially_. However afaik the XP cpu's are identical to the MP ones. All
> AMD K7 cpu's 'work' in SMP.

Correct. the EV6-Bus is just a point-to-point connection tho the northbridge. 
SO it is a bus that scales very well in SMP-systems.The most important parts 
of the SMP-logic are in the northbridge of the chipset, and not in the CPU 
(different to the Intel-solution) . Even Durons are SMP-capable.

greetings

Christian Bornträger

