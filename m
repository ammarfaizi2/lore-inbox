Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRBMXjo>; Tue, 13 Feb 2001 18:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131343AbRBMXjf>; Tue, 13 Feb 2001 18:39:35 -0500
Received: from adonis.lbl.gov ([128.3.5.144]:31496 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S131253AbRBMXjb>;
	Tue, 13 Feb 2001 18:39:31 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-pre2 ext2fs corruption
In-Reply-To: <E14Sown-0003HJ-00@the-village.bc.nu>
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 13 Feb 2001 15:37:49 -0800
In-Reply-To: <E14Sown-0003HJ-00@the-village.bc.nu> (message from Alan Cox on Tue, 13 Feb 2001 23:33:22 +0000 (GMT))
Message-ID: <87snlixigi.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > i came in today to find the computer completely locked up. after
> > rebooting and waiting for about an hour for fsck to finish i found the
> > following errors in the system log:
> 
> What hardware. I can see its some kind of scsi setup but what interfaces ?
> 

sorry. intel piii, with an adaptec AHA-294X Ultra2 scsi adapter. the
disk in question is a 9gb IBM disk Model: DNES-309170W Rev: SA30. is
this what you need? do you need more?

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
