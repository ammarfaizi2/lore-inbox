Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277288AbRJMRTt>; Sat, 13 Oct 2001 13:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277567AbRJMRTj>; Sat, 13 Oct 2001 13:19:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41734 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277288AbRJMRT3>; Sat, 13 Oct 2001 13:19:29 -0400
Subject: Re: A7A266 clock timer configuration lost
To: martin@kangaroo.at (Martin Bauer)
Date: Sat, 13 Oct 2001 18:24:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011013162434.26644A-100000@kangaroo.at> from "Martin Bauer" at Oct 13, 2001 04:25:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sSWw-0003I1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so are there only some A7A266 board with this problem an replacing
> the board could fix it - or do i just have to life with the bug and
> a spammed syslog.

The message is logged when we see the clock do odd things - the fixup we
do is harmless in this case
