Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTKRORw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTKRORw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:17:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12419 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263681AbTKRORu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:17:50 -0500
Date: Tue, 18 Nov 2003 09:19:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Pontus Fuchs <pof@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
In-Reply-To: <3FBA25CD.5020708@pobox.com>
Message-ID: <Pine.LNX.4.53.0311180915580.30324@chaos>
References: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
 <3FBA25CD.5020708@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Jeff Garzik wrote:

> Pontus Fuchs wrote:
> > Please! I don't want to start a flamewar if this is a good thing to do.
> > I'm just trying to scratch my own itch and I doubt that this project
> > changes the way Broadcom treats Linux users.
>
>
> Then help us reverse engineer the driver :)
>
> 	Jeff

Yes! Entirely! The BIG advantage of the NDIS-6 driver is
the established interface makes it possible to readily
reverse-engineer it, i.e., find out how it works. Many
of the network drivers use the same hardware core (ne).
It's the extra stuff like the transciever interface that
the NDIS drivers will expose.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


