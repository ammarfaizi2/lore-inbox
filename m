Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRALKV6>; Fri, 12 Jan 2001 05:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRALKVn>; Fri, 12 Jan 2001 05:21:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129730AbRALKVV>; Fri, 12 Jan 2001 05:21:21 -0500
Subject: Re: khttpd beaten by boa
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 12 Jan 2001 10:22:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <93mkpk$98k$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 12, 2001 02:03:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H1MM-00047g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TUX is evidence that khttpd can be done properly and
> > beat the pants off of anything done in userspace.
> > 
> 
> Then why don't we unload khttpd and put in Tux?

Tux needs the zero copy patches I believe so zero copy has to precede it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
