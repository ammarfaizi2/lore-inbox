Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSJKMFL>; Fri, 11 Oct 2002 08:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbSJKMFL>; Fri, 11 Oct 2002 08:05:11 -0400
Received: from [203.124.139.208] ([203.124.139.208]:14282 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id <S262425AbSJKMFL>;
	Fri, 11 Oct 2002 08:05:11 -0400
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Porting upper layer SCSI driver from Solaris to Linux
Date: Fri, 11 Oct 2002 17:39:31 +0530
Message-ID: <000001c2711f$0e40fc60$bf60a8c0@pcp13402>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are porting an upper layer device driver of SCSI (sd ) from Solaris to
Linux.

We want to develop an upper layer (for a block device) which can interact
with the middle generic layer(scsi_mod).What are the list of API's exposed
by the middle layer and where can I get a documentation of these i.e how
does the upper layer interact with the middle layer?
Also what methods do the upper layer needs to expose to the user
application?

Thanks nad Regards
Chandrasekhar

