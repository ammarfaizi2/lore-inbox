Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288395AbSANAPq>; Sun, 13 Jan 2002 19:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSANAP2>; Sun, 13 Jan 2002 19:15:28 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:16379 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S288395AbSANAPP>; Sun, 13 Jan 2002 19:15:15 -0500
Message-ID: <028b01c19c90$87300760$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200201132144.g0DLikH27385@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.18pre3-ac1
Date: Sun, 13 Jan 2002 19:15:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 14 Jan 2002 00:15:10.0080 (UTC) FILETIME=[87367000:01C19C90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Alan Cox" <alan@redhat.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 13, 2002 4:44 PM
Subject: Linux 2.4.18pre3-ac1


> People keep bugging me about the -ac tree stuff so this is whats in my
> current internal diff with the ll patch and the ide changes excluded.

<snip>

For the sake of completeness I ran my large inbound FTP transfer test (details
in the "Writeout in recent kernels..." thread) on this release. Performance and
observed writeout behavior was essentially the same as for 2.4.17, both stock
and with -rmap11a. Transfer time was 6:56 and writeout was uneven. 2.4.13-ac7 is
still the winner by a significant margin.

Hmmm...

--Adam


