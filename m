Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRAMXTd>; Sat, 13 Jan 2001 18:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbRAMXTX>; Sat, 13 Jan 2001 18:19:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130073AbRAMXTO>; Sat, 13 Jan 2001 18:19:14 -0500
Subject: Re: [PATCH] sparc64 compile fix
To: davem@redhat.com (David S. Miller)
Date: Sat, 13 Jan 2001 23:15:16 +0000 (GMT)
Cc: ppetru@ppetru.net (Petru Paler), linux-kernel@vger.kernel.org
In-Reply-To: <14944.56558.198555.536993@pizda.ninka.net> from "David S. Miller" at Jan 13, 2001 02:55:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HZtG-0006kl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What does this fix?  Things compile just fine without
> it and looking at the code it was intended to be of
> the original type.

2.4.0-ac has quota fixes (there are bad quota races in 2.4.0) and changes
to support 32bit uid. They aren't in the sparc64 diffs yet and until Linus
has the major bugs out they probably arent a major worry.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
