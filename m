Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130845AbRCFCBt>; Mon, 5 Mar 2001 21:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130843AbRCFCBj>; Mon, 5 Mar 2001 21:01:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4359 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130840AbRCFCBU>; Mon, 5 Mar 2001 21:01:20 -0500
Subject: Re: Linux 2.4.2ac12
To: ksi@cyberbills.com (Sergey Kubushin)
Date: Tue, 6 Mar 2001 02:04:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0103051439250.12620-100000@nomad.cyberbills.com> from "Sergey Kubushin" at Mar 05, 2001 02:43:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6pj-0008G3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 5 Mar 2001, Alexander Viro wrote:
> 
> New Adaptec driver does not build. It won't. People, can anyone enlighten me
> why do we use a user space library for a kernel driver at all?

aicasm is an assembler for the aic7xxx risc instruction code, not part of
the driver

