Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSKSQzb>; Tue, 19 Nov 2002 11:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSKSQza>; Tue, 19 Nov 2002 11:55:30 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:7861 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265475AbSKSQz3>; Tue, 19 Nov 2002 11:55:29 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: local link configuration daemon?
Date: Tue, 19 Nov 2002 18:02:28 +0100
Message-ID: <003b01c28fed$724a2c80$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just read this RFC on 'local link configuration' (mirrored at
http://keetweej.vanheusden.com/~folkert/draft-ietf-zeroconf-ipv4-linklocal.t
xt ) and I was wondering: is this planned to be in the kernel? Or should
occur this in userspace? (and if so; does it exist? freshmeat/google say it
doesn't)
Initially I thought I just configure an ip-address in that range on an
adapter, but then I read that there is this whole protocol of sending and
receiving arp-requests etc.


Folkert van Heusden

