Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbRE1DWP>; Sun, 27 May 2001 23:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262935AbRE1DWF>; Sun, 27 May 2001 23:22:05 -0400
Received: from smtp4vepub.gte.net ([206.46.170.25]:31769 "EHLO
	smtp4ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S262934AbRE1DV4>; Sun, 27 May 2001 23:21:56 -0400
Message-ID: <3B11C44D.A548801F@neuronet.pitt.edu>
Date: Sun, 27 May 2001 23:21:49 -0400
From: Rafael Herrera <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Hard lockup switching to X from vc; Matrox G400 AGP
In-Reply-To: <200105272147.f4RLlv300461@twopit.underworld>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced lost of the signal when switching from X to the console
when booting with vga=ext or some of the graphic modes. It was reported
here that the problem was the Matrox drivers.

Recently, with kernel 2.4.4+ and XFree 4.0.3 (@1280x1024/head)+ Matrox
drivers (http://matrox.com/mga/support/drivers/files/linux_06.cfm) and
booting with vga=794 (1280x1024) I have not had problems. I've a G450.

-- 
     Rafael
