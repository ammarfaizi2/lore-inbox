Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbRFBQWO>; Sat, 2 Jun 2001 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbRFBQVy>; Sat, 2 Jun 2001 12:21:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262610AbRFBQVr>; Sat, 2 Jun 2001 12:21:47 -0400
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sat, 2 Jun 2001 17:19:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <01060211530400.00350@athlon> from "Andreas Hartmann" at Jun 02, 2001 12:34:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156E7j-0001su-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got massive file corruptions with the kernels mentioned in the subject. I 
> can reproduce it every time.

Which other 2.4 trees have you tried ?

Does booting with ide=nodma help ? [only in -ac]


