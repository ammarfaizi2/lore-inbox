Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271073AbRHUCLJ>; Mon, 20 Aug 2001 22:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271076AbRHUCLA>; Mon, 20 Aug 2001 22:11:00 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:51728 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271073AbRHUCKr>; Mon, 20 Aug 2001 22:10:47 -0400
Subject: Re: Error compiling NTFS support in 2.4.9
From: Richard Russon <ntfs@flatcap.org>
To: mmayer@uci.edu
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200108210112.f7L1Cif15840@cx767414-b.irvn1.occa.home.com>
In-Reply-To: <200108210112.f7L1Cif15840@cx767414-b.irvn1.occa.home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 03:10:55 +0100
Message-Id: <998359855.28277.8.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meinhard,

> It seems that unistr.c ... broken since kernel 2.4.8.

Add the following to unistr.c

  #include <linux/kernel.h>

> I could not find Anton Altamarkov's e-mail address ...

It's in the MAINTAINERS and CREDITS files:

  aia21@cus.cam.ac.uk

FlatCap (Rich)
ntfs@flatcap.org



