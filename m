Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280788AbRKLNUJ>; Mon, 12 Nov 2001 08:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280776AbRKLNT7>; Mon, 12 Nov 2001 08:19:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280738AbRKLNTx>; Mon, 12 Nov 2001 08:19:53 -0500
Subject: Re: reseting /dev/tty
To: refuse7@poczta.fm
Date: Mon, 12 Nov 2001 13:19:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112130108.0A9C417DC3@pa160.grajewo.sdi.tpnet.pl> from "Gniazdowski" at Nov 12, 2001 02:01:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163H04-0005pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Howewer my brother has nvidia gf2mx card, and there is no frame buffer for 
> it. Many other cards does not have fbuffer support. So finaly the question:
> is there a way to reset /dev/tty ?

Without hardware docs no. In the case of nvidia the 2d drivers and frame
buffer for the 128 etc might actually have enough docs
