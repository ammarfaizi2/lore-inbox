Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272530AbRIFTni>; Thu, 6 Sep 2001 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272532AbRIFTn2>; Thu, 6 Sep 2001 15:43:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272530AbRIFTnS>; Thu, 6 Sep 2001 15:43:18 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 20:47:09 +0100 (BST)
Cc: stevev@efn.org (Steve VanDevender), wietse@porcupine.org (Wietse Venema),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906182518.3C907BC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 02:25:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f57F-0000L2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the kernel knows about subnets, then an application should be
> able to find out about them. Whether or not you agree with the
> application's reasons does not matter.

There I agree - entirely. I'd also say that an application using legacy
4.3BSD API's ought to get correct answers for configurations which are
validly expressed in that specific worldview

Alan
