Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSAPSa1>; Wed, 16 Jan 2002 13:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286215AbSAPSaQ>; Wed, 16 Jan 2002 13:30:16 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:34064 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S286220AbSAPSaD>; Wed, 16 Jan 2002 13:30:03 -0500
Subject: Re: ramdisk corruption problems - fixed in 2.4.18-pre4
From: Torrey Hoffman <thoffman@arnor.net>
To: linux-kernel@vger.kernel.org
Cc: tachino@open.nm.fujitsu.co.jp, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112202221040.1926-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112202221040.1926-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Jan 2002 10:33:10 -0800
Message-Id: <1011205993.23118.0.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a quick note to confirm that the ramdisk corruption fix
that went in to 2.4.18-pre4 does correct the problem for me.

I ran my test script with identical configs on -pre3 and -pre4. 
-pre3 has the problem, and -pre4 doesn't.

Thanks everyone who worked on this.

Torrey Hoffman

