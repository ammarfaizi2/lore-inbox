Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSAXISK>; Thu, 24 Jan 2002 03:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSAXISA>; Thu, 24 Jan 2002 03:18:00 -0500
Received: from pD9E607DD.dip.t-dialin.net ([217.230.7.221]:41725 "EHLO
	panzerknacker.falkenstr.de") by vger.kernel.org with ESMTP
	id <S284305AbSAXIRu>; Thu, 24 Jan 2002 03:17:50 -0500
To: linux-kernel@vger.kernel.org
Subject: Bug in Kernel or apm?
Reply-To: spam@kliche.org
Organization: GoInForm
From: Max Kliche <max@kliche.org>
Date: Thu, 24 Jan 2002 10:17:29 +0100
Message-ID: <87vgdshzva.fsf@kliche.org>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (artichoke)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
there is some misterious with apm and cdrom locks.

mount /mnt/cdrom
(the cdrom is locked and mounted, I can't get it open, OK)
apm -s
(the notebook goes to sleep, and me too :))
after awaking the notebook,
the cdrom is still mounted (ok),
but I can get it open, by pressing the eject button.
In my opinion, it is not ok.

Notebook: Dell Inspiron 8000
Kernel: 2.4.17
apm version: 3.0.2

Max

-- 
when I find my code in tons of trouble,    |  GoInForm
   friends and colleagues come to me,      |  Umweltrecht und 
       speaking words of wisdom            |  Informationssysteme
            "write in C"                   |  http://www.goinform.de
