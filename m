Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTANTGF>; Tue, 14 Jan 2003 14:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTANTGF>; Tue, 14 Jan 2003 14:06:05 -0500
Received: from [66.70.28.20] ([66.70.28.20]:32267 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265065AbTANTGE>; Tue, 14 Jan 2003 14:06:04 -0500
Date: Tue, 14 Jan 2003 20:14:20 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114191420.GA162@DervishD>
References: <20030114185934.GA49@DervishD> <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

> > libc, but I think that is more on the kernel side, that's why I ask
> Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> it with no problem.

    Any header where I can see the length for argv[0] or is this some
kind of unoficial standard? Just doing strcpy seems dangerous to me
(you can read 'paranoid'...).

    Thanks a lot for your answer, Richard :)
    Raúl
