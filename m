Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFIP7r>; Sun, 9 Jun 2002 11:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSFIP7q>; Sun, 9 Jun 2002 11:59:46 -0400
Received: from smtprelay9.dc2.adelphia.net ([64.8.50.53]:56457 "EHLO
	smtprelay9.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S293680AbSFIP7q>; Sun, 9 Jun 2002 11:59:46 -0400
Message-ID: <003301c20fce$ab097ac0$6501a8c0@WA1HCO>
From: "jeff millar" <wa1hco@adelphia.net>
To: <linux-kernel@vger.kernel.org>
Subject: Raid _still_ not compiling in v2.5.21
Date: Sun, 9 Jun 2002 11:59:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug just keeps on bugging me...

    raid5.c: In function 'raid5_plug_device':
    raid5.c:1247: 'tq_disk' undeclared (first use in this function)

Some patches show up in a search of lkml but I figured such a simple fix
would make it into the Linus tree quickly.

Did I miss something?  What's the issue here?



