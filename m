Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132795AbRAaBc5>; Tue, 30 Jan 2001 20:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRAaBcr>; Tue, 30 Jan 2001 20:32:47 -0500
Received: from quechua.inka.de ([212.227.14.2]:2149 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132795AbRAaBcf>;
	Tue, 30 Jan 2001 20:32:35 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
Message-Id: <E14Nm8S-0001P6-00@sites.inka.de>
Date: Wed, 31 Jan 2001 02:32:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A775FEB.D7614D98@Hell.WH8.TU-Dresden.De> you wrote:
> I guess the cleanest solution would be to allow variable setting of the
> maximum number of PCI busses in the config file, similar to the
> CONFIG_UNIX98_PTY_COUNT setting, so that "exotic" users with 32+ PCI
> busses can boost the standard value according to their needs, without
> having to increase kernel size for the normal users.

May even decrease the kernel for systems < 4 busses.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
