Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281259AbRKESJz>; Mon, 5 Nov 2001 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281265AbRKESJp>; Mon, 5 Nov 2001 13:09:45 -0500
Received: from modem-4041.leopard.dialup.pol.co.uk ([217.135.159.201]:39949
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S281259AbRKESJe>; Mon, 5 Nov 2001 13:09:34 -0500
Posted-Date: Mon, 5 Nov 2001 07:47:30 GMT
Date: Mon, 5 Nov 2001 07:47:29 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Wei Xiaoliang <weixl@caltech.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I know the number of current users in the system?
In-Reply-To: <3BE5BDFB.B49A8147@caltech.edu>
Message-ID: <Pine.LNX.4.21.0111050746280.9415-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei.

> I have a problem not clear: Is there any counter for the user number
> in linux?

> I want to do anexperiment which will get the number of current user
> in the system and try fair-share scheduling based on it. I read the
> sys.c and user.c but cannot find a counter for it. Is there any
> counter for this things?

Here's a simple shell command to provide that information:

	who | wc -l

Try it and see...

Best wishes from Riley.

