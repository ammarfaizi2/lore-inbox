Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266608AbRGEByV>; Wed, 4 Jul 2001 21:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266607AbRGEByM>; Wed, 4 Jul 2001 21:54:12 -0400
Received: from beasley.gator.com ([63.197.87.202]:49420 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266604AbRGEByB>; Wed, 4 Jul 2001 21:54:01 -0400
From: "George Bonser" <george@gator.com>
To: "Reza Roboubi" <reza@linisoft.com>,
        "Peter Bornemann" <eduard.epi@t-online.de>
Cc: "Ronald Bultje" <rbultje@ronald.bitfreak.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: >128 MB RAM stability problems (again)
Date: Wed, 4 Jul 2001 18:58:03 -0700
Message-ID: <CHEKKPICCNOGICGMDODJEELKDIAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3B43C13C.16BA4709@linisoft.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Nobody has answered a basic concern:
> Why does Win2k work while Linux does not?

The answer could be as simple as the fact that Linux might be trying to
write to the exact memory location that is bad but Win2k has not.  It might
also be that he in fact DOES have problems with win2k but is unaware of it,
that location might be used for data storage rather than program execution.

All I can say is this ... I have never used Windows on our production web
farms and Linux 2.4 appears to work just fine will many different sizes of
memory ... all greater than 128MB.



