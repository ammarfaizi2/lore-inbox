Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSGJXWR>; Wed, 10 Jul 2002 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGJXWQ>; Wed, 10 Jul 2002 19:22:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39954 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317672AbSGJXWP>; Wed, 10 Jul 2002 19:22:15 -0400
Subject: Re: [OT] /proc/cpuinfo output from some arch
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 11 Jul 2002 00:47:18 +0100 (BST)
Cc: hpa@zytor.com (H. Peter Anvin), pavel@ucw.cz (Pavel Machek),
       acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20020711001549.D17806@flint.arm.linux.org.uk> from "Russell King" at Jul 11, 2002 12:15:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SRB0-00086D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about /proc/sys/cpu/<number>/<datapoint> ?

What happens if the cpus are hot plugged and change ID while doing the
config 8)
