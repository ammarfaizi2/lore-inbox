Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbRENVWM>; Mon, 14 May 2001 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbRENVWC>; Mon, 14 May 2001 17:22:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63497 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262501AbRENVVt>; Mon, 14 May 2001 17:21:49 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 14 May 2001 22:18:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com> from "Jeff Garzik" at May 14, 2001 04:24:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPjE-0001Rl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note also that persistence of permissions and hardcoded in-kernel naming
> is a problem throughout proc...  It's not unique to in-driver
> filesystems.

And the /proc namespace is a walking testimony to why numbers are not the 
primarily problem in /dev space and tidyness
