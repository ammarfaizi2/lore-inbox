Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJLJbb>; Sat, 12 Oct 2002 05:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262878AbSJLJbb>; Sat, 12 Oct 2002 05:31:31 -0400
Received: from port-212-202-157-216.reverse.qsc.de ([212.202.157.216]:30995
	"EHLO kiff.netgen.de") by vger.kernel.org with ESMTP
	id <S262876AbSJLJba>; Sat, 12 Oct 2002 05:31:30 -0400
Message-ID: <1034422647.3da8097797dd3@smartmail.portrix.net>
Date: Sat, 12 Oct 2002 13:37:27 +0200
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

> > attempt to access beyond end of device
> > ide0(3,2): rw=0, want=1076371720, limit=19535040
>
At least not ide related. Just ext3 moaning.
I'm just reinstalling debian, e2fsck just killed most of my filesystem :-(
(including old dmesg/config).
I'll give 2.4.42 a try on a fresh install with ext_2_. But I think there
were no changes with respect to ext3 lately?!

jan

> Any messages _before_ these??
> 
> -- 
> Jens Axboe
> 


--
portrix.net GmbH
j.dittmer@portrix.net
