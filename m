Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRHMJao>; Mon, 13 Aug 2001 05:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270042AbRHMJaf>; Mon, 13 Aug 2001 05:30:35 -0400
Received: from NS.iNES.RO ([193.230.220.1]:37610 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S270028AbRHMJaY>;
	Mon, 13 Aug 2001 05:30:24 -0400
Date: Mon, 13 Aug 2001 12:30:38 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Re: AC'97 Audio -- what driver?
In-Reply-To: <Pine.LNX.4.33.0108131722190.1555-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.30.0108131229290.30560-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Jeff Chua wrote:

>
> /proc/pci says ...
>
>   Bus  0, device  31, function  5:
>     Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio
> (rev 2).
>       IRQ 11.
>       I/O at 0xdc00 [0xdcff].
>       I/O at 0xd800 [0xd83f].
>
>
> Is there a sound driver for this?
>

Use -> Intel ICH (i8xx) audio support.


