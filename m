Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRHMLbh>; Mon, 13 Aug 2001 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270102AbRHMLb1>; Mon, 13 Aug 2001 07:31:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3076 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270101AbRHMLbW>; Mon, 13 Aug 2001 07:31:22 -0400
Subject: Re: AC'97 Audio -- what driver?
To: jeffchua@silk.corp.fedex.com (Jeff Chua)
Date: Mon, 13 Aug 2001 12:33:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), jchua@fedex.com (Jeff Chua)
In-Reply-To: <Pine.LNX.4.33.0108131722190.1555-100000@boston.corp.fedex.com> from "Jeff Chua" at Aug 13, 2001 05:23:40 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WFyF-0007DK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Bus  0, device  31, function  5:
>     Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio
> (rev 2).
>       IRQ 11.
>       I/O at 0xdc00 [0xdcff].
>       I/O at 0xd800 [0xd83f].

Intel i810_audio

