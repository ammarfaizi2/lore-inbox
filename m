Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTBLTYK>; Wed, 12 Feb 2003 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267905AbTBLTYI>; Wed, 12 Feb 2003 14:24:08 -0500
Received: from adsl-66-124-158-132.dsl.sntc01.pacbell.net ([66.124.158.132]:6154
	"EHLO ia2020.localdomain") by vger.kernel.org with ESMTP
	id <S267901AbTBLTXo>; Wed, 12 Feb 2003 14:23:44 -0500
From: "Eric Chen" <echen@ateonix.com>
To: <linux-kernel@vger.kernel.org>
Subject: changing file copy to support extended attributes
Date: Wed, 12 Feb 2003 11:35:11 -0800
Message-ID: <NFBBIGILIDAABCBKKGMLAECOCCAA.echen@ateonix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to modify file copy so it supports extended attributes. I am using
extended attributes provided by the XFS filesystem, and right now when I
copy a file with an extended attribute bit set on, the copy of the file does
not preserve the extended attribute. I could use some help in this area
because I am not sure where to start. If anyone has some suggestions or can
offer me some help or resources to go to, please let me know.

Thanks,
Eric
echen@ateonix.com

