Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbRE0Sbi>; Sun, 27 May 2001 14:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262858AbRE0Sb2>; Sun, 27 May 2001 14:31:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28685 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262857AbRE0SbL>; Sun, 27 May 2001 14:31:11 -0400
Subject: Re: 2.4.4-ac17-2.4.5-ac1 oops in swapper process
To: crisper@optonline.net
Date: Sun, 27 May 2001 19:28:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0GE000F4IAVM20@mta4.srv.hcvlny.cv.net> from "crisper@optonline.net" at May 27, 2001 02:18:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1545Hc-0002Ct-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been getting a oops ever since 2.4.4-ac17 right after the kernel loads
> the sym53c895 driver.	I hand copied part of the oops before rebooting.  This
> happens in every kernel since 2.4.4-ac17.  I have changed my compiler from

Are you sure 2.4.4-ac16 runs. The reason I ask this is 2.4.4-ac16 updated
the symbios drivers. If ac15 works and ac16 fails then we have some good
clues


