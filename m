Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBNUKY>; Wed, 14 Feb 2001 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBNUKO>; Wed, 14 Feb 2001 15:10:14 -0500
Received: from www.ansp.br ([143.108.25.7]:24068 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S129059AbRBNUKK>;
	Wed, 14 Feb 2001 15:10:10 -0500
Message-ID: <3A8AD810.FA12DD31@ansp.br>
Date: Wed, 14 Feb 2001 17:10:08 -0200
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: What does "device or resource busy" mean ?
In-Reply-To: <3A8AC4BD.C37793E6@ansp.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For some unknown (to me) reason, this message has to do with X being
active. Leaving X causes the module to be correctly loaded. I guess X
should be using some resource that my module also wanted to use.

Marcus.

Marcus Ramos wrote:

> Hello,
>
> When I try to load module ttime.o - "insmod ttime.o" - I get the
> following message: "ttime.o: init_module: Device or resource busy".
> "lsmod" shows that ttime.o was effectively not loaded. I am using RH7
> with kernel 2.2.16-22. Does anyone have a guess on a possible reason for
> this and how to fix it, so the module can be normally loaded ?
>
> Thanks,
> Marcus.

