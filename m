Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRJOFPt>; Mon, 15 Oct 2001 01:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJOFPU>; Mon, 15 Oct 2001 01:15:20 -0400
Received: from cp1s4p1.dashmail.net ([216.36.32.37]:39688 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S273588AbRJOFPM>;
	Mon, 15 Oct 2001 01:15:12 -0400
Message-ID: <3BCA70DD.524D0D1@sr71.net>
Date: Sun, 14 Oct 2001 22:15:09 -0700
From: "David C. Hansen" <dave@sr71.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abhishek Rai <abbashake007@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question : spinlock
In-Reply-To: <20011013140756.24222.qmail@web11401.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek Rai wrote:
> 
> > Can anybody tell me/ direct me to some tutorial/web
> > site/manual etc/ where i can gather the concepts of
> > Spin locks in linux, and get a good idea of the
> > commonly used functions like : spin_lock_irqsave()
> > etc.
> > abhishek
This is a pretty comprehensive list of all global spinlocks in the
kernel.  It simply summarizes how they are used.  
http://lse.sourceforge.net/lockhier/
-- 
David C. Hansen
dave@sr71.net
ICQ: 7785546
AIM: HansenDC79
