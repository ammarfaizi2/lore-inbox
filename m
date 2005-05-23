Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEWLve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEWLve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 07:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEWLve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 07:51:34 -0400
Received: from smtpout02-04.prod.mesa1.secureserver.net ([64.202.165.194]:13010
	"HELO smtpout02-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S261226AbVEWLvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 07:51:32 -0400
Message-ID: <4291C38D.1040705@coyotegulch.com>
Date: Mon, 23 May 2005 07:50:37 -0400
From: Scott Robert Ladd <lkml@coyotegulch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050512)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: False "lost ticks" on dual-Opteron system (=> timer twice as
 fast)
References: <200505081445.26663.bernd.paysan@gmx.de>	 <d93f04c705052112426ee35154@mail.gmail.com>	 <428F9FA6.1000800@coyotegulch.com> <d93f04c70505211500216d8614@mail.gmail.com>
In-Reply-To: <d93f04c70505211500216d8614@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/21/05, Scott Robert Ladd <lkml@coyotegulch.com> wrote:
>>I *don't* have any timer problems running 2.6.11-r8 (gentoo) on a dual
>>Opteron 250 system using a Tyan K8W 2885. Perhaps the problem is that
>>the two of you are running SCSI main drives, and I'm not?

Hendrik Visage wrote:
> IDE/PATA, SATA (libsata/SCSI) and external USB/FireWire adapters

Hi,

You can find my .config at:

    http://www.coyotegulch.com/distfiles/corwin.config

Perhaps a comparison of my .config to yours might identify the source of
your problem.

..Scott

