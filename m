Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129163AbQKMJbd>; Mon, 13 Nov 2000 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQKMJbY>; Mon, 13 Nov 2000 04:31:24 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:37504 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129163AbQKMJbI>;
	Mon, 13 Nov 2000 04:31:08 -0500
Message-ID: <20001113173105.A7086@saw.sw.com.sg>
Date: Mon, 13 Nov 2000 17:31:05 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Allen, David B" <David.B.Allen@chase.com>, michael@pmcl.ph.utexas.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel etherpro100 on 2.2.18p21 vs 2.2.18p17
In-Reply-To: <93BA6BFC5E48D4118A8200508B6BBC4924AB7A@sf1-mail01.hamquist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <93BA6BFC5E48D4118A8200508B6BBC4924AB7A@sf1-mail01.hamquist.com>; from "Allen, David B" on Fri, Nov 10, 2000 at 04:24:12PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 10, 2000 at 04:24:12PM -0800, Allen, David B wrote:
> FWIW, I have a dual-proc SuperMicro motherboard P3DM3 with integrated
> Adaptec SCSI and Intel 8255x built-in NIC.
> 
> Sometimes on a cold boot I get the "kernel: eth0: card reports no RX
> buffers" that repeats, but if I follow it with a warm boot the message
> doesn't appear (even on subsequent warm boots).  So this is definitely
> reproducible, but it doesn't happen every time.

Yes, it's a problem, and it indeed happens not every time.
Dragan Stancevic has promised to check it against Intel's errata.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
