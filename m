Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136449AbREINwO>; Wed, 9 May 2001 09:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbREINwE>; Wed, 9 May 2001 09:52:04 -0400
Received: from pille1.addcom.de ([62.96.128.35]:29701 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S136449AbREINv4>;
	Wed, 9 May 2001 09:51:56 -0400
Date: Wed, 9 May 2001 15:52:14 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Jochen Striepe <jochen@tolot.escape.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AVM Fritz! PCI v2.0
In-Reply-To: <20010509111520.B26016@tolot.escape.de>
Message-ID: <Pine.LNX.4.33.0105091539310.2169-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Jochen Striepe wrote:

> is there any Linux driver for the AVM Fritz! PCI v2.0 ISDN card
> available? Using vanilla 2.2.19's HiSax driver doesn't seem to work,
> and I found nothing at AVM's web page [1]. Did I miss someting?
>
> [1] http://www.avm.de/

You're right, the HiSax driver doesn't work with this card. Your only
option is the binary-only CAPI driver, provided by AVM. You should find
further information on the web page you mentioned.

--Kai


