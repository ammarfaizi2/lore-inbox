Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTCCQHf>; Mon, 3 Mar 2003 11:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTCCQHf>; Mon, 3 Mar 2003 11:07:35 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:526 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S266379AbTCCQHe> convert rfc822-to-8bit; Mon, 3 Mar 2003 11:07:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cciss: add passthrough ioctl
Date: Mon, 3 Mar 2003 10:17:55 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640451336D@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: add passthrough ioctl
Thread-Index: AcLhmVuLQaJipK7gSJKvr5NQ4w33iQAACvjg
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Mar 2003 16:17:56.0365 (UTC) FILETIME=[7334C3D0:01C2E1A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Mon, Mar 03, 2003 at 09:26:40AM +0600, Stephen Cameron wrote:
> > Because, in order to flash the array controller firmware,
> > it's got to be done that way...
> 
> I don't buy this. Sorry. What's against creating a device for this
> controller itself ? 
> (And yes, the kernel could use a formal ioctl number for "upgrade firmware") 

Arg.  Now I wish I didn't already port that code to 10 distributions.
Please shoot me.

How do you want it done?

-- steve
