Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSBINW5>; Sat, 9 Feb 2002 08:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSBINWp>; Sat, 9 Feb 2002 08:22:45 -0500
Received: from [62.47.19.142] ([62.47.19.142]:9349 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S288936AbSBINWf>;
	Sat, 9 Feb 2002 08:22:35 -0500
Message-ID: <3C651CC1.DAFDB2B6@webit.com>
Date: Sat, 09 Feb 2002 13:57:37 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with both CONFIG_FB_SIS_300 and CONFIG_FB_SIS_315
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

you're right. Both options don't (yet) work together.

I have a new version of sisfb around the corner (partly new code from
SiS themselves). The code is currently in a testing phase and will be
committed as soon as it is stable.

The goal is to have the same code basis for the sisfb as well as the X
driver. This is under development - and it will solve the issue you
described as well.

For the status of the current development, see
http://www.webit.com/tw/linuxsis630.shtml

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
