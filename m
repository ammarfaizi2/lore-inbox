Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319444AbSIGGZN>; Sat, 7 Sep 2002 02:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319442AbSIGGZN>; Sat, 7 Sep 2002 02:25:13 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:37605 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319441AbSIGGZM>; Sat, 7 Sep 2002 02:25:12 -0400
Date: Sat, 7 Sep 2002 08:28:34 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>
Subject: Re: qlogic failover multipath
In-Reply-To: <20020906153437.GA2164@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0209070822250.21784-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.15.0.1; VDF: 6.15.0.6
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Mike Anderson wrote:

> You can edit the qla_settings.h file and set MPIO_SUPPORT to 1 or I
> believe if you use the qla2x00src-v6.1b5-fo archive that this should
> already be set to 1.

Thank you, I will try at Monday. It is set to 0 in b5.
But my archive is named: qla2x00src-v6.1b5.tgz
-fo seems to come only from enabling MPIO ?

Oktay Akbal


