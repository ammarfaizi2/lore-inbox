Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279813AbRKFRBv>; Tue, 6 Nov 2001 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRKFRBm>; Tue, 6 Nov 2001 12:01:42 -0500
Received: from [212.113.174.249] ([212.113.174.249]:29474 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S279813AbRKFRBZ>;
	Tue, 6 Nov 2001 12:01:25 -0500
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
from: "Ricardo Ferreira" <stormlabs@gmx.net>
to: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
subject: [More info] Re: PROBLEM: cdrecord, ide-scsi and all 2.4.x kernels
Date: Tue, 6 Nov 2001 17:00:49 +0000
X-Mailer: KMail [version 1.3.1]
cc: "Andre Hedrick" <andre@aslab.com>, "Jens Axboe" <axboe@suse.de>,
        "Gadi Oxman" <gadio@netvision.net.il>
In-Reply-To: <EXCH01SMTP012FVbS9s0001fe99@smtp.netcabo.pt> <EXCH01SMTP016BSqEMD00000a12@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP016BSqEMD00000a12@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <EXCH01SMTP02YRsUs5Q0001d750@smtp.netcabo.pt>
X-OriginalArrivalTime: 06 Nov 2001 16:57:22.0489 (UTC) FILETIME=[1A6B2290:01C166E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to my own message again.

On Monday 05 November 2001 15:46, Ricardo Ferreira wrote:
> ide-scsi. Both fail. ide-cd fails on read and ide-scsi on read & write. I
> plan to test with another CDRW drive just to be sure the drive isn't the
> problem.

I just tested another CDRW drive. Exactly the same messages. Again 2.2.18 & 
2.2.19 have no problems. This is surely a bug in the 2.4.x kernels. This 
drive works perfectly in another computer running a 2.4.x kernel (SuSE 7.2 - 
dont know the kernel version now).

Its driving me crazy.
