Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJLQer>; Sat, 12 Oct 2002 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSJLQer>; Sat, 12 Oct 2002 12:34:47 -0400
Received: from port-212-202-157-216.reverse.qsc.de ([212.202.157.216]:64261
	"EHLO kiff.netgen.de") by vger.kernel.org with ESMTP
	id <S261283AbSJLQeq>; Sat, 12 Oct 2002 12:34:46 -0400
Message-ID: <1034448049.3da86cb1bc72a@smartmail.portrix.net>
Date: Sat, 12 Oct 2002 20:40:49 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: harddisk corruption with 2.5.41bk and tcq enabled
References: <200210121050.01471.jan@jandittmer.de> <20021012091653.GD26719@suse.de>
In-Reply-To: <20021012091653.GD26719@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.5.42 has no changes in this area, so it's probably not safe for you
> either.

Tried it anyway. Nothing better. Seems to happen also with tcq disabled. I've
for now downgraded to 2.4 ... Don't want to reinstall again.
I don't have a serial console available. So I'm sorry but I can't give you any
further clues. X locks up completly after some minutes, on reboot e2fsck gives a
ton of errors (also with ext2 btw). Or can you point me to something I can try
safely?! Perhaps I'll give 2.5.40 a try again tomorrow. That was the latest
revision working iirc. But for now I'm tired and a bit scared ;-)

jan
