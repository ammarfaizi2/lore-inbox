Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRGBKP3>; Mon, 2 Jul 2001 06:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbRGBKPT>; Mon, 2 Jul 2001 06:15:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262997AbRGBKPD>; Mon, 2 Jul 2001 06:15:03 -0400
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: adam@yggdrasil.com (Adam J. Richter)
Date: Mon, 2 Jul 2001 11:14:01 +0100 (BST)
Cc: kaos@ocs.com.au, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        rhw@MemAlpha.CX, rmk@arm.linux.org.uk
In-Reply-To: <200107020552.WAA02457@adam.yggdrasil.com> from "Adam J. Richter" at Jul 01, 2001 10:52:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H0iP-0005hF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> appears to be indented (or at least the first statement in the block
> is indented).  None of these three variables has the semantics that
> I think you you described above.

Ok so that just leaves fixing any Xconfig/menuconfig versions of the change
and it can go in

Excellent

