Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277335AbRJJRce>; Wed, 10 Oct 2001 13:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277338AbRJJRcY>; Wed, 10 Oct 2001 13:32:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277335AbRJJRcT>; Wed, 10 Oct 2001 13:32:19 -0400
Subject: Re: Dilemma: Replace Escalade with Adaptec 2400A or Promise Supertrak66?
To: jkniiv@hushmail.com
Date: Wed, 10 Oct 2001 18:33:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110101408.f9AE87w91970@mailserver1.hushmail.com> from "jkniiv@hushmail.com" at Oct 10, 2001 07:08:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rNER-0008UB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know that both are based on an I2O architecture so there's some hope, at 
> least, even if there is very little support officially by Adaptec or Promise.
> Alan himself has proclaimed that the Supertrak works for him just fine, but 
> I presume there are no Linux-based utilities available yet. Is there then 
> any way to find out if a drive has gone south and needs to be replaced --
>  kernel log messages, maybe?

I2O provides the basic info needed to check stuff (it uses an HTML interface
bizarrely enough). The DPT/Adaptec doesn't use this so Im not sure what
its monitoring setup is

As to support

Promise sent me the card, and answered questions on firmware funnies
Adaptec wrote their own open source drivers 

Alan
