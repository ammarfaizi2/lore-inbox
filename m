Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135660AbREFMsi>; Sun, 6 May 2001 08:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135663AbREFMs3>; Sun, 6 May 2001 08:48:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29445 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135660AbREFMsR>; Sun, 6 May 2001 08:48:17 -0400
Subject: Re: Athlon possible fixes
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 6 May 2001 13:51:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010506142346.C31269@metastasis.f00f.org> from "Chris Wedgwood" at May 06, 2001 02:23:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wO16-00023N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There really needs to be a hardware fix... this doesn't stop some
> application having it's owne optimised code from breaking on some
> hardware (think games and similation software perhaps).

prefetch is virtually addresses. An application would need access to /dev/mem
or similar. So the only folks I think it might actually bite are the Xserver
people.


