Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280662AbRKSTn6>; Mon, 19 Nov 2001 14:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKSTns>; Mon, 19 Nov 2001 14:43:48 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:21920 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280662AbRKSTn2>; Mon, 19 Nov 2001 14:43:28 -0500
Date: 19 Nov 2001 19:43:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8D9JvBF1w-B@khms.westfalen.de>
In-Reply-To: <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>
Subject: Re: x bit for dirs: misfeature?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jas88@cam.ac.uk (James A Sutherland)  wrote on 19.11.01 in <E165qq7-0003QD-00@mauve.csi.cam.ac.uk>:

> [james@dax p2i]$ ls test
> ls: test/file: Permission denied
> [james@dax p2i]$ ls -l test
> ls: test/file: Permission denied
> total 0
>
> (There is something incredibly stupid about the first one: ls is unable to,
> er, read the name of the named file?!)

Try 'ls --color=none'. Then go read 'info ls'.

MfG Kai
