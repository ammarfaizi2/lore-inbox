Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRLKPwp>; Tue, 11 Dec 2001 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRLKPwg>; Tue, 11 Dec 2001 10:52:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36113 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281217AbRLKPwV>; Tue, 11 Dec 2001 10:52:21 -0500
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
To: hps@intermeta.de
Date: Tue, 11 Dec 2001 16:01:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9v59ql$pkh$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Dec 11, 2001 03:47:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DpLg-0005f3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not happy about your usage of magic numbers, either. So it is
> still running on solid 2.2.19 until further notice (or until Rik loses
> his patience. ;-) )

Andrea did the 2.2.19 VM as well, but that one is somewhat better
documented, and doesn't have the use-once funnies.

Alan
