Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSIFJtl>; Fri, 6 Sep 2002 05:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSIFJtl>; Fri, 6 Sep 2002 05:49:41 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:6832 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318447AbSIFJtk>; Fri, 6 Sep 2002 05:49:40 -0400
Date: Fri, 6 Sep 2002 11:53:43 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: qlogic failover multipath
In-Reply-To: <Pine.LNX.4.44.0209051043570.2844-100000@omega.s-tec.de>
Message-ID: <Pine.LNX.4.44.0209061142150.12655-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1; AVE: 6.15.0.1; VDF: 6.15.0.6
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we do have some Problems with some qlogic 2202f fibrechannel card.
When trying to use failover via plugging out some cable or using
qlogics sansurfer to set an alternate path, there seem to be no errors,
but everything works extremly slow and does not recover.

This was used with driver 6.0b23 as from suse kernel 2.4.18.

When trying 6.1b2 or b5 the disks get recognized as multiple scsi-disks,
is this wanted for use with md multipath personality ?
Is there a way to enable previos behavior ?

Please reply also to me directly.

Thanks

Oktay Akbal


