Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284940AbRLKI6l>; Tue, 11 Dec 2001 03:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284929AbRLKI6b>; Tue, 11 Dec 2001 03:58:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64267 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284940AbRLKI6S>;
	Tue, 11 Dec 2001 03:58:18 -0500
Date: Tue, 11 Dec 2001 09:58:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Scarfoglio <scarfoglio@arpacoop.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre8: lockups whem mounting scsi cdrom
Message-ID: <20011211085812.GH13498@suse.de>
In-Reply-To: <3C154C27.2030202@arpacoop.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C154C27.2030202@arpacoop.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Carl Scarfoglio wrote:
> HW: MB Asus A7V, 256MB Ram, Athlon 800 MHz,four HD attache to standard
> ATA and ATA-100 Promise controller, 1 Realtek 8029 ethernet adapter,
> Adaptec 2904 (AIC 7850), 1 scsi CD-writer (Waitec. i.e. Philips 2200 or
> so), Teac scsi CD-ROM, 1 Mustek A3 plugged to external scsi connector.
> The Adaptec has Irq 11 exclusilively.
> SW: SuSE 6.3 with some changes, gcc 2.9.3.
> 
> I am running 2.5.1-pre8. I cannot mount data CD. When I execute the
> mount command, on any drive, a hard lockup follows. No messages from the
> mount command, no noise from the drives.
> The PC hangs solid: keyboard and mouse are dead, no telnet access, when
> in X the session is dead. I must flip the power switch.

Thanks, I'll take a look.

> But I can write CD's with cdrecord and play audio CD's!!

Ok

-- 
Jens Axboe

