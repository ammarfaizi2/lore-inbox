Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293516AbSCFNJx>; Wed, 6 Mar 2002 08:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293518AbSCFNJn>; Wed, 6 Mar 2002 08:09:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14488 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S293516AbSCFNJ1>;
	Wed, 6 Mar 2002 08:09:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Mar 2002 13:09:25 GMT
Message-Id: <UTC200203061309.NAA197223.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: bitkeeper / IDE cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From dalecki@evision-ventures.com Wed Mar  6 13:53:24 2002

    > I very much distrust the possibility of defining any abstract interface.
    > For special purpose things one just wants to send certain commands and
    > data to the disk, and user space knows which commands and what data,
    > and the kernel doesn't, so has to allow user space access.

    Well then please answer the following:
    ...

    Actually Alan Cox convinced me that it still makes sense to have a
    IOCTL_ATA_DRIVE_TAKE_ME_HARD_FROM_THE_REAR, but ...

Aha, so you are convinced. That is what I hoped to achieve.

Andries
