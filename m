Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSICR4k>; Tue, 3 Sep 2002 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318846AbSICR4k>; Tue, 3 Sep 2002 13:56:40 -0400
Received: from viefep15-int.chello.at ([213.46.255.19]:35092 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id <S318614AbSICR4k>; Tue, 3 Sep 2002 13:56:40 -0400
Reply-To: <kt@aon.at>
From: "Thomas Koller" <kt@aon.at>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel Oops after X-Server shutdown
Date: Tue, 3 Sep 2002 20:07:42 +0200
Message-ID: <BGEJLCHCKCKFMBGCEFHFOEOLCAAA.kt@aon.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.NEB.4.44.0209031454410.696-100000@mimas.fachschaften.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Adrian Bunk wrote:

> Hi Thomas,

Hi Adrian,


> 1. Could you try whether 2.4.20-pre5 [1] fixes this (with 2.4.20-pre5 you
>    don't need the external DRI Modules)?

Thanks for help. I tried 2.4.20-pre5 with acpi patch and no it works. The
Problem seems to be solved.

> TIA
> Adrian

Best Regards
Thomas


