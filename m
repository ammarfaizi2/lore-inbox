Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRKFQKE>; Tue, 6 Nov 2001 11:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKFQJy>; Tue, 6 Nov 2001 11:09:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16650 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279243AbRKFQJi>; Tue, 6 Nov 2001 11:09:38 -0500
Subject: Re: Mylex/Compaq RAID controller placement in config
To: dana.lacoste@peregrine.com (Dana Lacoste)
Date: Tue, 6 Nov 2001 16:16:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk ('Alan Cox'),
        roy@karlsbakk.net
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2863@ottonexc1.ottawa.loran.com> from "Dana Lacoste" at Nov 06, 2001 08:01:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1618uA-0000wM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and then you hit the whole I20 problem.  Half my raid controllers
> aren't under either of those two menus.

I2O is a tricky one - the fusion mpt stuff too. I've not found a better
answer for that
