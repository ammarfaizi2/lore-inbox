Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRCESKl>; Mon, 5 Mar 2001 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130176AbRCESKV>; Mon, 5 Mar 2001 13:10:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130170AbRCESKO>; Mon, 5 Mar 2001 13:10:14 -0500
Subject: Re: Annoying CD-rom driver error messages
To: law@sgi.com (LA Walsh)
Date: Mon, 5 Mar 2001 18:13:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AA3D180.24661D6B@sgi.com> from "LA Walsh" at Mar 05, 2001 09:48:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZzTo-0007Rv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this isnt a kernel problem, its a _very_ stupid app
> ---
> 	Must be more than one stupid app...

Could well be. You have something continually trying to open your cdrom and
see if there is media in it
