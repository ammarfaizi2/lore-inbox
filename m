Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129711AbRBESWQ>; Mon, 5 Feb 2001 13:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbRBESWF>; Mon, 5 Feb 2001 13:22:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129711AbRBESVz>; Mon, 5 Feb 2001 13:21:55 -0500
Subject: Re: modversions.h source pollution in 2.4
To: adilger@turbolinux.com (Andreas Dilger)
Date: Mon, 5 Feb 2001 18:21:09 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <200102051816.f15IGoT11015@webber.adilger.net> from "Andreas Dilger" at Feb 05, 2001 11:16:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PqGF-0003s5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "#include <linux/modversions.h>" line is needed...  Also, what kernel
> versions is this needed for?  The LVM code uses a common source file
> for 2.2 and 2.4, so should the #include stay in for 2.2?

It shouldnt there for 2.2 either
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
