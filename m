Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbRFQLaO>; Sun, 17 Jun 2001 07:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbRFQLaG>; Sun, 17 Jun 2001 07:30:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28175 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264723AbRFQL37>; Sun, 17 Jun 2001 07:29:59 -0400
Subject: Re: 2.4.5: K7 MCE reporting not enabled due missing mcheck_init()
To: paluch@KMLinux.fjfi.cvut.cz (Henryk Paluch)
Date: Sun, 17 Jun 2001 12:28:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106171240100.3936-100000@KMLinux.fjfi.cvut.cz> from "Henryk Paluch" at Jun 17, 2001 12:49:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BajN-0002Qr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems, that 2.4.5 is supposed to support K7 Machine Check Exception
> in arch/i386/kernel/bluesmoke.c. However mcheck_init() is called from

The changes needed for this are not yet fully merged from -ac. Your change
looks fine

