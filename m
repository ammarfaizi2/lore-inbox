Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRIMMu2>; Thu, 13 Sep 2001 08:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271569AbRIMMuS>; Thu, 13 Sep 2001 08:50:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269186AbRIMMuI>; Thu, 13 Sep 2001 08:50:08 -0400
Subject: Re: suggest project
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Thu, 13 Sep 2001 13:54:41 +0100 (BST)
Cc: tushar_k5@rediffmail.com (tushar korde), linux-kernel@vger.kernel.org
In-Reply-To: <20010913144253.T11046@mea-ext.zmailer.org> from "Matti Aarnio" at Sep 13, 2001 02:42:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hW0w-0006W9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Find out why Linux PS/2 keyboard and mouse drivers don't support
>    disconnect, and reconnect of said devices.   Then fix things so
>    that keyboard can be replugged at any time, and it gets into
>    sensible state, same with the mouse.

Reconnect is device specific. For mice at least gpm and X have to handle it
