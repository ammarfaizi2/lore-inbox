Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRBMKwv>; Tue, 13 Feb 2001 05:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbRBMKwm>; Tue, 13 Feb 2001 05:52:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20488 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129465AbRBMKwe>; Tue, 13 Feb 2001 05:52:34 -0500
Subject: Re: LILO and serial speeds over 9600
To: hpa@transmeta.com (H. Peter Anvin)
Date: Tue, 13 Feb 2001 10:51:56 +0000 (GMT)
Cc: timw@splhi.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        Werner.Almesberger@epfl.ch (Werner Almesberger),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A887E68.CFBF6FC5@transmeta.com> from "H. Peter Anvin" at Feb 12, 2001 04:23:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Sd3v-0001OF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's the whole crux of the matter.  For something like this, you *will*
> drop data under certain circumstances.  I suspect it's better to have
> this done in a controlled manner, rather than stop completely, which is
> what TCP would do.

Why do you plan to drop data ? That seems unneccessary.

