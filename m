Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbRENRC1>; Mon, 14 May 2001 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRENRCR>; Mon, 14 May 2001 13:02:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262273AbRENRCG>; Mon, 14 May 2001 13:02:06 -0400
Subject: Re: OOPS on 2.4.4-ac4
To: s.torri@lancaster.ac.uk (Stephen Torri)
Date: Mon, 14 May 2001 17:58:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0105121244020.3535-100000@dyn7d0.dhcp.lancs.ac.uk> from "Stephen Torri" at May 12, 2001 12:46:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zLgQ-0000yh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> update to 2.4.4-ac8 today. In regards to the module the source code is
> available from nvidia for inspection. The library that they want you to

Its unreadable and the binary stuff touches hardware directly. Nvidia driver
loaded - bugs to nvidia. vmware loaded bugs to vmware, both loaded, god help
you, nobody else will

