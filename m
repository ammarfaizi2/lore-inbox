Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCXPoJ>; Sun, 24 Mar 2002 10:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSCXPn7>; Sun, 24 Mar 2002 10:43:59 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:54780 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S293521AbSCXPno>; Sun, 24 Mar 2002 10:43:44 -0500
Message-ID: <025c01c1d34a$ab89f3f0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E16oaKY-00012l-00@the-village.bc.nu>
Subject: Re: Linux 2.4.19-pre3-ac6
Date: Sun, 24 Mar 2002 10:43:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 24 Mar 2002 15:43:40.0217 (UTC) FILETIME=[AB8B7A90:01C1D34A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> Again treat this with care. This mostly fixes the CD bug a lot of people hit
so
> that the IDE code can get further testing

FWIW, this has been running here for a little over a day with no problems.
Machine hosts MySql and PostgreSql DBs so IDE is fairly well beat up. Also
tested server-side NFS by exporting a directory into which I un-tarred a few
dozen kernel trees from the client side.

--Adam


