Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131911AbRBWTYR>; Fri, 23 Feb 2001 14:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131922AbRBWTYH>; Fri, 23 Feb 2001 14:24:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131911AbRBWTX6>; Fri, 23 Feb 2001 14:23:58 -0500
Subject: Re: EXT2-fs error
To: ian@wehrman.com
Date: Fri, 23 Feb 2001 19:26:17 +0000 (GMT)
Cc: mhaque@haque.net, adilger@turbolinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010223131205.A10434@wehrman.com> from "Ian Wehrman" at Feb 23, 2001 01:12:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WNrA-0006vM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Possibly the result of the 'silent' bug in 2.4.1?
> 
> you are not the only one who found this bug. immediately after booting 2.4.2 i
> received dozens of these errors, resulting in _major_ filesystem corruption.
> after a half hour of fsck'ing i managed to bring the machine back into a usable

Had you been running 2.4.1 before that ?
