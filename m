Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310183AbSCKQO2>; Mon, 11 Mar 2002 11:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310184AbSCKQOS>; Mon, 11 Mar 2002 11:14:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310183AbSCKQOM>; Mon, 11 Mar 2002 11:14:12 -0500
Subject: Re: IDE on linux-2.4.18
To: root@chaos.analogic.com
Date: Mon, 11 Mar 2002 16:29:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1020311110057.2492A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 11, 2002 11:01:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kSg8-00010S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hda:	Cannot handle device with more than 16 heads giving up.

You enabled the old ST506 driver not the newer IDE one
