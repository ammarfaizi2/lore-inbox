Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266817AbSKUPwO>; Thu, 21 Nov 2002 10:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266818AbSKUPwO>; Thu, 21 Nov 2002 10:52:14 -0500
Received: from [213.187.195.158] ([213.187.195.158]:20728 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S266817AbSKUPwM>; Thu, 21 Nov 2002 10:52:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jan <jan@seismo.ifg.ethz.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7M266-D
References: <3DDCEEC6.5030806@seismo.ifg.ethz.ch>
	<1037893069.7660.26.camel@irongate.swansea.linux.org.uk>
From: Marcus Sundberg <marcus@ingate.com>
Date: 21 Nov 2002 16:58:57 +0100
In-Reply-To: <1037893069.7660.26.camel@irongate.swansea.linux.org.uk>
Message-ID: <vefztu52ym.fsf@inigo.ingate.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Base 2.4 doesnt have a driver for the 7441. The -ac tree does and it
> seems SuSE also picked up the newer driver for it.

As of 2.4.19 it does...
Both grep and my AM7266-D boards agrees with me on that. ;-)

To the original poster; did you enable CONFIG_BLK_DEV_AMD74XX ?

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
