Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUJrk>; Tue, 21 Nov 2000 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbQKUJra>; Tue, 21 Nov 2000 04:47:30 -0500
Received: from www.gmx.net ([194.221.183.50]:2581 "HELO www10.gmx.net")
	by vger.kernel.org with SMTP id <S129208AbQKUJrQ>;
	Tue, 21 Nov 2000 04:47:16 -0500
Date: Tue, 21 Nov 2000 10:17:09 +0100 (MET)
To: egger@suse.de
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB: Wacom Graphire mouse wheel does not work anymore
From: karl.gustav@gmx.net
MIME-Version: 1.0
In-Reply-To: <20001121021309.F1F145962@Nicole.muc.suse.de>
Message-ID: <8129.974798229@www10.gmx.net>
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0001826769@gmx.net
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Authenticated-IP: [194.138.37.36]
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I used the IMPS/2 compatible mouse emulation of the wacom driver
> > (/dev/input/mice).
> 
>  Don't do that. It's evil. Use the xinput driver instead.

Hm, there is no stable xinput driver available for XFree 4.0 and xinput
does not support the wheel, too :-(

K.

-- 
Sent through GMX FreeMail - http://www.gmx.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
