Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129297AbRBSRno>; Mon, 19 Feb 2001 12:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBSRne>; Mon, 19 Feb 2001 12:43:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129297AbRBSRnZ>; Mon, 19 Feb 2001 12:43:25 -0500
Subject: Re: ymfpci is 2.4.1-ac18
To: proski@gnu.org (Pavel Roskin)
Date: Mon, 19 Feb 2001 17:43:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), zaitcev@metabyte.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0102191226030.766-100000@fonzie.nine.com> from "Pavel Roskin" at Feb 19, 2001 12:28:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UuL7-00040v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  *  - 2001/01/07 Replace the OPL3 part of CONFIG_SOUND_YMFPCI_LEGACY code with
>  *    native synthesizer through a playback slot.
> 
> It sounds more promising than it is :-(

Non old style OSS synthesizers dont support the legacy /dev/sequencer interface
