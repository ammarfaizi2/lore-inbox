Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbRGDUB4>; Wed, 4 Jul 2001 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266163AbRGDUBr>; Wed, 4 Jul 2001 16:01:47 -0400
Received: from beasley.gator.com ([63.197.87.202]:9221 "EHLO beasley.gator.com")
	by vger.kernel.org with ESMTP id <S266161AbRGDUBd>;
	Wed, 4 Jul 2001 16:01:33 -0400
From: "George Bonser" <george@gator.com>
To: "Ronald Bultje" <rbultje@ronald.bitfreak.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: >128 MB RAM stability problems (again)
Date: Wed, 4 Jul 2001 13:05:38 -0700
Message-ID: <CHEKKPICCNOGICGMDODJOELADIAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <994279551.1116.0.camel@tux>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> my house with more than 128 MB RAM?!? Can someone please point out to me
> that he's actually running kernel-2.4.x on a machine with more than 128
> MB RAM and that he's NOT having severe stability problems?

Running 2.4.6-pre and 2.4.6 proper on several machines. Quite busy and all
have 256 to 512MB of RAM. As I type this, I am in the process of converting
an entire production server farm over to 2.4.6 from 2.2.19 as the 2.4.6-pre
series proved out well on a test machine in that farm.  No stability
problems at all. The only reboots were for patching up the kernel to the
next -pre revision on that test box.

