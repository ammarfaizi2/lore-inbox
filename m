Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbRFSUCN>; Tue, 19 Jun 2001 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbRFSUCD>; Tue, 19 Jun 2001 16:02:03 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:17675 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S264755AbRFSUBz>; Tue, 19 Jun 2001 16:01:55 -0400
Reply-To: <martin.frey@compaq.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Alan Cox'" <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.5-ac16  (linux_booted_ok: only on Intel implemented)
Date: Tue, 19 Jun 2001 16:01:42 -0400
Message-ID: <014801c0f8fa$a98ebbb0$0100007f@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20010619183135.A24337@lightning.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

linux_booted_ok(), called from init/main.c is not implemented on
other architectures than Intel.

Regards, Martin
