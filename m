Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275770AbRI0FaY>; Thu, 27 Sep 2001 01:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275768AbRI0FaP>; Thu, 27 Sep 2001 01:30:15 -0400
Received: from chiara.elte.hu ([157.181.150.200]:60940 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275767AbRI0FaD>;
	Thu, 27 Sep 2001 01:30:03 -0400
Date: Thu, 27 Sep 2001 07:28:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole - log kernel messages over the network.
 2.4.10.
In-Reply-To: <20010926174605.E1140@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109270726090.1679-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Andreas Dilger wrote:

> Ok, I read the docs, and this is indeed a target MAC address.  It may
> still be easier to accept a regular MAC address like
> target_mac=XX:XX:XX:XX:XX:XX as the module parameter (and a
> target_ip=A.B.C.D).  In any case, here is a script to automate this
> (ugly because of the conversions needed).

thanks - i've put this script into the userspace tarball.

	Ingo

