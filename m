Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSK1I4p>; Thu, 28 Nov 2002 03:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSK1I4p>; Thu, 28 Nov 2002 03:56:45 -0500
Received: from proxy.firewall-by-call.de ([62.116.172.146]:2185 "EHLO
	ibis.city-map.de") by vger.kernel.org with ESMTP id <S265277AbSK1I4o>;
	Thu, 28 Nov 2002 03:56:44 -0500
Message-ID: <079a01c296bd$1d51f150$6600a8c0@topconcepts.net>
From: "Sonke Ruempler" <ruempler@topconcepts.com>
To: "Oleg Drokin" <green@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com> <077201c296bb$43b4ac40$6600a8c0@topconcepts.net> <20021128115708.A2792@namesys.com>
Subject: Re: reiserfs bug
Date: Thu, 28 Nov 2002 10:04:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, but you seems to have faulty hardware (bad harddrive or something).
> Reiserfs cannot tolerate bad blocks in journal area right now.
> I'd suggest you to make a backup of your device and then to replace bad
> harddrive.

umm, that are originally freecom 20gig ide hdds in a firewire-case, i
replaced the hdds with 120gig maxtor hdds and they worked for 2 weeks until
today.

maybe the firewire<->ide converter is corrupted?

