Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131948AbQLJSs6>; Sun, 10 Dec 2000 13:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131939AbQLJSss>; Sun, 10 Dec 2000 13:48:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131641AbQLJSsb>; Sun, 10 Dec 2000 13:48:31 -0500
Subject: Re: Linux 2.2.18 almost...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Sun, 10 Dec 2000 18:20:22 +0000 (GMT)
Cc: rothwell@holly-springs.nc.us (Michael Rothwell),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012100828490.798-100000@penguin.homenet> from "Tigran Aivazian" at Dec 10, 2000 08:29:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145B5E-0006oW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.moses.uklinux.net/patches/dontdiff
> 
> the old one contained vmlinux.lds which would is good for kdb kernels
> where vmlinux.lds is automatically generated at runtime.

vmlinux.lds for 2.2 is dynamically generated. I should probably have used your
dontdiff ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
