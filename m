Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131055AbRCGMzW>; Wed, 7 Mar 2001 07:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131056AbRCGMzM>; Wed, 7 Mar 2001 07:55:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58629 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131055AbRCGMy6>; Wed, 7 Mar 2001 07:54:58 -0500
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No
To: greearb@candelatech.com (Ben Greear)
Date: Wed, 7 Mar 2001 12:57:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3AA5B0F3.143E0528@candelatech.com> from "Ben Greear" at Mar 06, 2001 08:54:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14adVH-0000wL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not arguing it was a smart thing to do, but I would think that the
> fs/kernel/driver writers could keep really nasty and un-expected things
> from happenning.  For instance, the driver could dis-allow any new (non-hdparm)

Like stopping root from using rm -r ? Where is the line drawn

