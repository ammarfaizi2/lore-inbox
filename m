Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313116AbSC1JYY>; Thu, 28 Mar 2002 04:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSC1JYP>; Thu, 28 Mar 2002 04:24:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40970 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313112AbSC1JYA>; Thu, 28 Mar 2002 04:24:00 -0500
Subject: Re: DE and hot-swap disk caddies
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 28 Mar 2002 09:39:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andersen@codepoet.org,
        andre@linux-ide.org (Andre Hedrick), josh@stack.nl (Jos Hulzink),
        jw@pegasys.ws (jw schultz), linux-kernel@vger.kernel.org
In-Reply-To: <3CA2CDA1.7090505@evision-ventures.com> from "Martin Dalecki" at Mar 28, 2002 09:00:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qWNt-0007Ij-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then there is this talking around about the "tristate of some" device.
> I'm really a bit sick of it. Becouse there is no such a state
> like a tri-state. We have just bus drivers on both ends.
> They are implemented usually as Schmidt triggers. They have three
> possible states on output: low voltage, high voltage, high resistance.

Which is one, two, three states -> tri-state.

Electronics terminology then abuses that to mean the high impedance state (not
high resistance please if we are going to be picky).

Alan
