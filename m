Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSBTBgS>; Tue, 19 Feb 2002 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBTBf6>; Tue, 19 Feb 2002 20:35:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64779 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290744AbSBTBfw>; Tue, 19 Feb 2002 20:35:52 -0500
Date: Tue, 19 Feb 2002 17:32:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Francois Romieu <romieu@cogenit.fr>, <linux-kernel@vger.kernel.org>,
        <khc@pm.waw.pl>, <davem@redhat.com>
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <3C703B46.79890E96@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202191732320.1443-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Feb 2002, Jeff Garzik wrote:
> Francois Romieu wrote:
> > [0/3]:
> > - SIOCDEVICE -> SIOCWANDEV conversion
> > - hdlc_proto -> raw_hdlc_proto
> 
> patch looks ok to me.

Jeff, are yu willing to merge these things?

		Linus

