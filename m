Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSCSSPZ>; Tue, 19 Mar 2002 13:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSCSSPT>; Tue, 19 Mar 2002 13:15:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27405 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288953AbSCSSPB>; Tue, 19 Mar 2002 13:15:01 -0500
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
To: adilger@clusterfs.com (Andreas Dilger)
Date: Tue, 19 Mar 2002 18:30:35 +0000 (GMT)
Cc: pdh@utter.chaos.org.uk (Peter Hartley), linux-kernel@vger.kernel.org
In-Reply-To: <20020319141554.GL470@turbolinux.com> from "Andreas Dilger" at Mar 19, 2002 07:15:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nONX-0008NU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (c) rlimit should not apply to block devices.

Also correct.

> There were patches for this floating around, and I thought they made it
> into 2.4.18, but they did not.

I saw some stuff. I may even have looked at merging it with -ac. Not sure
if it got fixed finally there or not. A resend of those diffs would be
good.
