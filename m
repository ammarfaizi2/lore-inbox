Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273812AbRIXGrm>; Mon, 24 Sep 2001 02:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273813AbRIXGrc>; Mon, 24 Sep 2001 02:47:32 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:30470 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273812AbRIXGrX>; Mon, 24 Sep 2001 02:47:23 -0400
Date: 24 Sep 2001 08:45:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <89SDQHhmw-B@khms.westfalen.de>
In-Reply-To: <20010923234111.A16873@leeor.math.technion.ac.il>
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E15lFVk-0000Ex-00@the-village.bc.nu> <alan@lxorguk.ukuu.org.uk> <E15kyyG-0000mq-00@dext.rous.org> <E15lFVk-0000Ex-00@the-village.bc.nu> <20010923234111.A16873@leeor.math.technion.ac.il>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nyh@math.technion.ac.il (Nadav Har'El)  wrote on 23.09.01 in <20010923234111.A16873@leeor.math.technion.ac.il>:

> Just too bad Debian's policy is to make ^? the erase character - pretty
> much the opposite of what most Unix users used before that. Pretending

Actually, the main argument for chosing this was that this *was* the  
traditional behaviour - as seen by vtxxx terminals and traditional Unix  
applications like emacs. (If ^H was the traditional erase, how come emacs  
wants ^H for help? Doesn't add up.)

MfG Kai
