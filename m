Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292135AbSBOVVV>; Fri, 15 Feb 2002 16:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292144AbSBOVVK>; Fri, 15 Feb 2002 16:21:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1553 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292135AbSBOVVC>; Fri, 15 Feb 2002 16:21:02 -0500
Subject: Re: Disgusted with kbuild developers
To: davej@suse.de (Dave Jones)
Date: Fri, 15 Feb 2002 21:34:52 +0000 (GMT)
Cc: esr@thyrsus.com (Eric S. Raymond),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020215213833.J27880@suse.de> from "Dave Jones" at Feb 15, 2002 09:38:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bq0L-0004Ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Sure CML2 fixes some bits that are not easily fixed in CML1,
>  but I wonder sometimes how much of it is/was fixable.

Pretty much all of it. I wrote a proof of concept parser that can deduce
the set of rules that must be enforced and what must be changed when you
hit an option
