Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSANVKm>; Mon, 14 Jan 2002 16:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSANVKb>; Mon, 14 Jan 2002 16:10:31 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:42502 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S289068AbSANVJ2>;
	Mon, 14 Jan 2002 16:09:28 -0500
Date: Mon, 14 Jan 2002 20:51:24 +0000
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-Id: <20020114205124.2f05fc56.spyro@armlinux.org>
In-Reply-To: <Pine.LNX.4.40.0201141139370.22904-100000@dlang.diginsite.com>
In-Reply-To: <E16QCc6-0002bb-00@the-village.bc.nu>
	<Pine.LNX.4.40.0201141139370.22904-100000@dlang.diginsite.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny Mon, 14 Jan 2002 11:44:59 -0800 (PST) David Lang gathered a
sheaf of electrons and etched in their motions the following immortal
words:

> doesn't matter, they are likly to be found on dedicated servers where
> the flexibility of modules is not needed and the slight performance
> advantage is desired.

Exactly WHAT performance advantage? once the module is loaded, its loaded.
most modules use the same code to handle modular and non-modular builds
anyhow (look at the ide drivers, for example)
