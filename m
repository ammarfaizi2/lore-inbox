Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285496AbRLYMmr>; Tue, 25 Dec 2001 07:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLYMm1>; Tue, 25 Dec 2001 07:42:27 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:63947 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S285507AbRLYMmQ>; Tue, 25 Dec 2001 07:42:16 -0500
Date: 25 Dec 2001 13:41:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8FZUN8A1w-B@khms.westfalen.de>
In-Reply-To: <20011224233515.B3932@elf.ucw.cz>
Subject: Re: [PATCH] console_loglevel broken on ia64 (and possibly other archs)
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3C23BD30.F8C3B2E1@dif.dk> <3C23BD30.F8C3B2E1@dif.dk> <20011224233515.B3932@elf.ucw.cz>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz (Pavel Machek)  wrote on 24.12.01 in <20011224233515.B3932@elf.ucw.cz>:

> > This patch fixes the console_loglevel variable(s) so that code that
> > assumes the variables occupy continuous storage does not break (and
> > overwrite other data).
>
> It seems to me you are adding feature? And unneeded one, also.

What feature would that be?


MfG Kai
