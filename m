Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSDONTw>; Mon, 15 Apr 2002 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312680AbSDONTv>; Mon, 15 Apr 2002 09:19:51 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:7468 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S312681AbSDONTu>; Mon, 15 Apr 2002 09:19:50 -0400
Date: Mon, 15 Apr 2002 15:16:04 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Alpha Beta <abbashake007@lycos.com>
cc: linux-kernel@vger.kernel.org, <abbashake007@yahoo.com>
Subject: Re: Signal Handler
In-Reply-To: <LKHGAPLICDAPDCAA@mailcity.com>
Message-Id: <Pine.LNX.4.44.0204151513390.3067-100000@phobos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Alpha Beta wrote:

> i am trying to implement a user level thread package with preemption
> between threads.

Look at how OpenAFS handles this, or use GNU pth.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

