Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130604AbQK1EHb>; Mon, 27 Nov 2000 23:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130770AbQK1EHV>; Mon, 27 Nov 2000 23:07:21 -0500
Received: from bos1d.delphi.com ([199.93.4.4]:16973 "EHLO bos1d.delphi.com")
        by vger.kernel.org with ESMTP id <S130768AbQK1EHN>;
        Mon, 27 Nov 2000 23:07:13 -0500
Date: Mon, 27 Nov 2000 21:36:33 -0600
From: Kevin Krieser <kkrieser@delphi.com>
Subject: RE: out of swap
In-Reply-To: <3A22EC94.2A434703@mindspring.com>
To: linux-kernel@vger.kernel.org
Message-id: <000b01c058ec$6791abe0$0701a8c0@thinkpad>
MIME-version: 1.0
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What would I like it to do?  Warn me maybe before my swap goes to
> zero.  Kill the
> program that is doing this possibly.  Allow me to set a per
> process memory / swap
> limit so that no one process can suck up my system resources.
>

There are several programs available with the typical Linux installation
that allows you to monitor swap space.  For example, xosview.

There are also settings you can make in Netscape that supposedly limit disk
space usage and memory usage.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
