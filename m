Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVACGKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVACGKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 01:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVACGKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 01:10:50 -0500
Received: from mf2.realtek.com.tw ([220.128.56.22]:10257 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S261390AbVACGKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 01:10:45 -0500
Message-ID: <005d01c4f15a$ef4bf620$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: How to use udftools to make up a DVD with DVD-Video format
Date: Mon, 3 Jan 2005 14:10:33 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.1|January 28, 2004) at
 2005/01/03 =?Bog5?B?pFWkyCAwMjoxMjowNA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.1|January 28, 2004) at 2005/01/03
 =?Bog5?B?pFWkyCAwMjoxMjowOA==?=,
	Serialize complete at 2005/01/03 =?Bog5?B?pFWkyCAwMjoxMjowOA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
We try to make up a DVD-Video disc on Linux.
DVD-Video disc contains a UDF/ISO9660 filesystem, and every file in it
should occupy the right sectors.
I know that mkisofs can do this, but we want to record video on-the-fly.
mkisofs doesn't support this functionality.
Therefore we would like to use UDF filesystem and udftools to do this.
Can I use them to make up a DVD with a UDF/ISO9660 filesystem and every file
in it occupies specified sectors?

Thanks and regards,
Colin

