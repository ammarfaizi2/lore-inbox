Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRBMALH>; Mon, 12 Feb 2001 19:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBMAK5>; Mon, 12 Feb 2001 19:10:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23558 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129367AbRBMAKx>; Mon, 12 Feb 2001 19:10:53 -0500
Subject: Re: LILO and serial speeds over 9600
To: hpa@transmeta.com (H. Peter Anvin)
Date: Tue, 13 Feb 2001 00:11:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Werner.Almesberger@epfl.ch (Werner Almesberger),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A887777.3895D3F8@transmeta.com> from "H. Peter Anvin" at Feb 12, 2001 03:53:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ST3g-000094-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sure you can.  That doesn't mean it's the right solution.

And the UDP proposal will be at least as big if it does retransmits, and if
it doesnt , its junk. It will also need as much buffering, if not the same
packing trick

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
