Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282819AbRLWOLR>; Sun, 23 Dec 2001 09:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLWOK6>; Sun, 23 Dec 2001 09:10:58 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:51898 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S282523AbRLWOKv>; Sun, 23 Dec 2001 09:10:51 -0500
Date: 23 Dec 2001 14:22:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8FRVhs5Xw-B@khms.westfalen.de>
In-Reply-To: <a0439g$7a5$1@cesium.transmeta.com>
Subject: Re: Booting a modular kernel through a multiple streams file
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <a0439g$7a5$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 23.12.01 in <a0439g$7a5$1@cesium.transmeta.com>:

> Pax is just a single utility which does cpio and tar.

Well, pax is in POSIX 2001. Neither tar nor cpio are.

Of course, pax is specified to be able to work with both tar and cpio  
formats. And a new extended tar format which is what you get when you try  
to stuff a completely different format into tar.

MfG Kai
