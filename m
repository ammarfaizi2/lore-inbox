Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129935AbRBSQIX>; Mon, 19 Feb 2001 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbRBSQIN>; Mon, 19 Feb 2001 11:08:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129935AbRBSQHy>; Mon, 19 Feb 2001 11:07:54 -0500
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
To: hps@intermeta.de
Date: Mon, 19 Feb 2001 16:07:41 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        Werner.Almesberger@epfl.ch (Werner Almesberger),
        hps@tanstaafl.de (Henning P. Schmiedehausen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010219131542.D16663@forge.intermeta.de> from "Henning P . Schmiedehausen" at Feb 19, 2001 01:15:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Usql-0003ll-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, is it legal to put changes to a twin licensed driver in the Linux
> kernel tree back into the same driver in the BSD tree?

Just make it plain that patches and contributions to that driver must be
dual licensed. We have several shared drivers with BSD and most people seem
happy that small fixes to a dual or BSD licensed drivers should go back under
the original license. In fact I'd say I'm not the only one who would find it
impolite otherwise.

