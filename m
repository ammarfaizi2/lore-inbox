Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273997AbRIURZ4>; Fri, 21 Sep 2001 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274153AbRIURZk>; Fri, 21 Sep 2001 13:25:40 -0400
Received: from hermes.domdv.de ([193.102.202.1]:60165 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S273997AbRIURZ1>;
	Fri, 21 Sep 2001 13:25:27 -0400
Message-ID: <XFMail.20010921192411.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <41B7E064ABA@vcnet.vc.cvut.cz>
Date: Fri, 21 Sep 2001 19:24:11 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: spurious interrupt with ac kernel but not with vanilla
Cc: alan@lxorguk.ukuu.org.uk, Linux Kernel <linux-kernel@vger.kernel.org>,
        Luigi Genoni <kernel@Expansa.sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This happens to me too (Asus A7V, KT133). It happens since I remember -
> at least since Christmas, and for me it happens after unspecified time
> after boot - varying from few seconds (during initscripts) to few
> minutes. After it happens once, everything is apparently satisified
> and no more spurious interrupts occurs (until next reboot).

Same behaviour on a bunch of EpoX 8KTA+, KT133. Didn't care about it. Doesn't
happen on a variety of PIII boards (Intel clones and Asus) so it looks like a
KT133 issue. Kernel config is UP with APIC support on all systems.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
