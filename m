Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2RdB>; Mon, 29 Jan 2001 12:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRA2Rcw>; Mon, 29 Jan 2001 12:32:52 -0500
Received: from [207.113.109.32] ([207.113.109.32]:54021 "HELO cih.com")
	by vger.kernel.org with SMTP id <S129101AbRA2Rcd>;
	Mon, 29 Jan 2001 12:32:33 -0500
Date: Mon, 29 Jan 2001 12:32:32 -0500 (EST)
From: "Craig I. Hagan" <hagan@cih.com>
To: Romain Kang <romain@kzsu.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <200101291624.IAA74849@kzsu.stanford.edu>
Message-ID: <Pine.LNX.4.20.0101291231520.30022-100000@www.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One approach to the endless eepro100 headaches would be to port
> the FreeBSD if_fxp driver to Linux.  After all, drivers have been
> ported between these OSs before; e.g., the aic7xxx SCSI adapter.
> However, I see no evidence that this has been attempted.  Can
> someone tell me what I'm obviously missing?

Had I my druthers, i'd see the intel e100 driver brought into the kernel. It
seems to work quite well with the eepro100 boards.

-- craig

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
