Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289171AbSA1Oi0>; Mon, 28 Jan 2002 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSA1OiR>; Mon, 28 Jan 2002 09:38:17 -0500
Received: from iwd_mail.intware.com ([216.94.87.36]:58897 "EHLO
	iwd_mail.intware.com") by vger.kernel.org with ESMTP
	id <S289171AbSA1OiH>; Mon, 28 Jan 2002 09:38:07 -0500
Message-ID: <F7EB06D3ED62D311A15600104B6D909F442073@IWD_MAIL>
From: Dimitrie Paun <dimi@intelliware.ca>
To: "'Stelian Pop'" <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2.4.18-pre7] sonypi driver update
Date: Mon, 28 Jan 2002 09:16:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stelian Pop [mailto:stelian.pop@fr.alcove.com]

Hi Stelian :)

> This new version of the driver is also capable to turn on/off
> this laptop's bluetooth subsystem (using new ioctls, you will
> need the updated user mode tools - spicctrl - from 
> http://www.alcove-labs.org/en/software/sonypi/).

Why do we keep proliferating ioctls, instead of nice ctrl files?

--
Dimi.
