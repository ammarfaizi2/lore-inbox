Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbREQMsy>; Thu, 17 May 2001 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261414AbREQMso>; Thu, 17 May 2001 08:48:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261413AbREQMsi>; Thu, 17 May 2001 08:48:38 -0400
Subject: Re: alpha/2.4.x: CPU misdetection, possible miscompilation
To: mike@rainbow.studorg.tuwien.ac.at (Michael Wildpaner)
Date: Thu, 17 May 2001 13:45:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105161739440.31072-100000@rainbow.studorg.tuwien.ac.at> from "Michael Wildpaner" at May 17, 2001 02:23:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150N9p-0005KA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> possible miscompilation of smp_tune_scheduling:
> 	These versions of gcc
> 		gcc version 2.95.3 20010111
> 		gcc version 2.95.4 20010506

Does gcc 2.96 or the gcc 3.0 snapshot also show this problem ?
