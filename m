Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTJ1Rcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTJ1Rcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:32:35 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:40577 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S264058AbTJ1Rcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:32:33 -0500
Message-ID: <000b01c39d79$6a187fe0$0100000a@Biocalderoni.hu>
From: "Szucs Arpad" <giraffe@danubian.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] netmos 9845 4 serial + 1 parallel port pci card
Date: Tue, 28 Oct 2003 18:32:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested it on kernel 2.4.20. If anyone else has this card and tests it I
would like to hear about it.

Changes parport_serial.c and pci_ids.h.

Todo: tell the difference between 6 ports serial and 4 ports serial and 1
parallel or other variants. If anyone has suggestions please send them to my
e-mail address

http://vnet.hu/ipeb/netmos-9735-9835-9845-2.4.20-22.patch.gz

send comments to giraffe@danubian.hu


Arpad Szucs

