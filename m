Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRJUSh5>; Sun, 21 Oct 2001 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJUShr>; Sun, 21 Oct 2001 14:37:47 -0400
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:65153 "EHLO
	backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S276522AbRJUShe>; Sun, 21 Oct 2001 14:37:34 -0400
Message-Id: <200110211838.f9LIc7Tn002375@backfire.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=US-ASCII
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Networkadministrator WH8/DD
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX-EISA hang at boot
Date: Sun, 21 Oct 2001 20:38:07 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E15vJQA-0006SS-00@the-village.bc.nu>
In-Reply-To: <E15vJQA-0006SS-00@the-village.bc.nu>
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 21. Oktober 2001 16:17 schrieb Alan Cox:
> > so - do anybody know what's wrong with aic7xxx and who broke it after
> > 2.4.7ac5 so it can't work on hardware described here ?
>
> For EISA use aic7xxx_old or get the latest version from Justin Gibbs site
> -
Why doesn't Linus and you merge it? The 6.2.4 runs pretty stable on our EISA 
box.

-Gregor
