Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276322AbRI1WZn>; Fri, 28 Sep 2001 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276324AbRI1WZe>; Fri, 28 Sep 2001 18:25:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60683 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276322AbRI1WZV>; Fri, 28 Sep 2001 18:25:21 -0400
Subject: Re: CPU frequency shifting "problems"
To: andrew.grover@intel.com (Grover, Andrew)
Date: Fri, 28 Sep 2001 23:30:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), torvalds@transmeta.com,
        padraig@antefacto.com, linux-kernel@vger.kernel.org
In-Reply-To: <8FB7D6BCE8A2D511B88C00508B68C2081971D8@orsmsx102.jf.intel.com> from "Grover, Andrew" at Sep 27, 2001 06:24:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n69G-000089-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> effective frequency at all. Even if you knew all the details of SpeedStep
> (and I've seen the same MS doc you have Alan and was surprised at its
> detail) you'd still be hosed if the CPU throttles...you'd be hosed in a
> *good* way because at least any delays would be longer (not shorter) than
> expected but your times would be off nonetheless.

Remember you get an interrupt from the transition that you can steal from
the ROM gunge, or is that another deep intel secret you can't comment on 8)

Just why are intel so obsessed by secrets about something every other vendor
does anyway ? 

Alan
