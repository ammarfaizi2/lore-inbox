Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRCLCTR>; Sun, 11 Mar 2001 21:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRCLCTI>; Sun, 11 Mar 2001 21:19:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129364AbRCLCSu>; Sun, 11 Mar 2001 21:18:50 -0500
Subject: Re: linux localization
To: xing.fei@fujixerox.co.jp (XingFei)
Date: Mon, 12 Mar 2001 02:21:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <010b01c0aa95$5802c740$78b2f981@ksp.fujixerox.co.jp> from "XingFei" at Mar 12, 2001 10:39:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cHxf-000178-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My work will concern with the internationalization of Linux
> So, could anybody tell me what kinds of features should be in the
> consideration when linux be localized from english to Japanese or chinese,
> say using 2 bytes character set.

Most of the Linux userspace libraries are set up for handling UTF8 and
other internationalisations. Fonts are more of an issue and lack of application
translations. Filenames are defined to be UTF8.

