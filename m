Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbQLGX2e>; Thu, 7 Dec 2000 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbQLGX2Y>; Thu, 7 Dec 2000 18:28:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131349AbQLGX2M>; Thu, 7 Dec 2000 18:28:12 -0500
Subject: Re: 2.2.18 vs 2.4.0 proc_fs.c
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Thu, 7 Dec 2000 23:00:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3A2FF454.373A5142@holly-springs.nc.us> from "Michael Rothwell" at Dec 07, 2000 03:34:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144A1O-000371-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is 2.2.18 proc_fs.c different than both 2.2.17 and 2.4.0? Cox, would
> you accept a patch that makes 2.2.18 define create_proc_info_entry and
> related functions the same way that 2.4.0 does?

Send me a diff and I'll be happy to
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
