Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSFWXFp>; Sun, 23 Jun 2002 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSFWXFo>; Sun, 23 Jun 2002 19:05:44 -0400
Received: from khms.westfalen.de ([62.153.201.243]:29633 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317188AbSFWXFo>; Sun, 23 Jun 2002 19:05:44 -0400
Date: 24 Jun 2002 00:56:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: lm@bitmover.com
Message-ID: <8RVhG6aHw-B@khms.westfalen.de>
In-Reply-To: <20020622122656.W23670@work.bitmover.com>
Subject: Re: latest linus-2.5 BK broken
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <m1lm97rx16.fsf@frodo.biederman.org> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com> <m1lm97rx16.fsf@frodo.biederman.org> <20020622122656.W23670@work.bitmover.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lm@bitmover.com (Larry McVoy)  wrote on 22.06.02 in <20020622122656.W23670@work.bitmover.com>:

> Just out of curiousity, have you actually ever worked on a fine grain
> threaded OS?  One that scales to at least 32 processors?  Solaris?  IRIX?
> Others?  It makes a difference, if you've been there, your perspective is

IIRC, you said that your proposed system should have one oslet per about 4  
CPUs. And I see many people claiming that current Linux locking is aimed  
at being good with about 4 CPUs.

Maybe I'm dense, but it seems to me that means current Linux locking is  
aimed at exactly the spot where you argue it should be aimed *anyway*.

What am I not seeing?

MfG Kai
