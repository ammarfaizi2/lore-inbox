Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313290AbSC1XPD>; Thu, 28 Mar 2002 18:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313287AbSC1XOx>; Thu, 28 Mar 2002 18:14:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313290AbSC1XOg>; Thu, 28 Mar 2002 18:14:36 -0500
Subject: Re: PROBLEM: kernel v2.4.18, faulty virtual mem code?
To: Stephan.Fuhrmann@stud.uni-karlsruhe.de
Date: Thu, 28 Mar 2002 23:30:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0203290003220.2835-100000@t28a301.tennessee.uni-karlsruhe.de> from "Stephan Fuhrmann" at Mar 29, 2002 12:10:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qjM5-0000Dz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got a small problem while running a game under X11.
> It looks to me that there is a problem in the virtual
> memory code.
> My machine doesn't crash, it just dumps a kernel stack
> to the console.

Are you using the Nvidia binary only driver ?
