Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273709AbRI0RWu>; Thu, 27 Sep 2001 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273719AbRI0RWl>; Thu, 27 Sep 2001 13:22:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273709AbRI0RWe>; Thu, 27 Sep 2001 13:22:34 -0400
Subject: Re: 2.4.9-ac15 sluggish
To: xavier.bestel@free.fr (Xavier Bestel)
Date: Thu, 27 Sep 2001 18:27:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <1001602003.17481.7.camel@nomade> from "Xavier Bestel" at Sep 27, 2001 04:46:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mewt-0004a6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I gave 2.4.9-ac15 a try on my dual-pIII, 700MB
> 
> I tried to run /usb/bin/automake on the gstreamer project (current
> automake has a bug which sucks all ram, gstreamer provides its own)

ac15 has a merge error that causes bad VM behaviour. Ac16 is brewing
