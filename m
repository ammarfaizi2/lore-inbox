Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRLGMa2>; Fri, 7 Dec 2001 07:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLGMaS>; Fri, 7 Dec 2001 07:30:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276591AbRLGMaD>; Fri, 7 Dec 2001 07:30:03 -0500
Subject: Re: kernel 2.4.15
To: tb@westend.com
Date: Fri, 7 Dec 2001 12:39:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C10B4BA.6090303@westend.com> from "Thomas Braun" at Dec 07, 2001 01:23:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CKHX-0005gD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hi group,
> can someone tell me what is going wrong with my kernel?

Downgrade your debian binutils or enable CONFIG_HOTPLUG
