Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRDBUPQ>; Mon, 2 Apr 2001 16:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRDBUPG>; Mon, 2 Apr 2001 16:15:06 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:40201 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131309AbRDBUOv>; Mon, 2 Apr 2001 16:14:51 -0400
Date: 02 Apr 2001 20:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7z5pl1CHw-B@khms.westfalen.de>
In-Reply-To: <3AC7C719.3080403@kalifornia.com>
Subject: Re: bug database braindump from the kernel summit
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0104011640280.25794-100000@dlang.diginsite.com> <3AC7C719.3080403@kalifornia.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ben@kalifornia.com (Ben Ford)  wrote on 01.04.01 in <3AC7C719.3080403@kalifornia.com>:

> Why not have the /proc/config option but instead of being plain text,
> make it binary with a userspace app that can interpret it?
>
> It could have a signature as to kernel version + patches and the rest
> would be just bits.

> You'd have
> 2.4.3-pre3:1101111100000100000000 . . . . .

Another option would be to put a checksum of the config, and still keep  
the config separate - at least you could tell if you had the right config  
for the kernel.


MfG Kai
