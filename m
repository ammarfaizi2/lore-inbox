Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbQJ3WEX>; Mon, 30 Oct 2000 17:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbQJ3WEN>; Mon, 30 Oct 2000 17:04:13 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:49169 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129339AbQJ3WEB>; Mon, 30 Oct 2000 17:04:01 -0500
Date: Mon, 30 Oct 2000 17:02:12 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Peter Samuelson <peter@cadcamlab.org>,
        Linux Kernel Developer <linux_developer@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001030170212.X6207@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <dalecki@evision-ventures.com> <200010302050.e9UKo7312002@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010302050.e9UKo7312002@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Mon, Oct 30, 2000 at 05:50:07PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 05:50:07PM -0300, Horst von Brand wrote:
> Martin Dalecki <dalecki@evision-ventures.com> said:
> > Peter Samuelson wrote:
> 
> [...]
> 
> > > * Red Hat "2.96" or CVS 2.97 will probably break any known kernel.
> 
> > Works fine for me and 2.4.0-test10-pre5... however there are tons of
> > preprocessor warnings in some drivers.
> 
> CVS (from 20001028 or so) gave a 2.4.0.10.6/i686 that crashed on boot, no
> time to dig deeper yet.

CVS 2.97 is known to miscompile e.g. buffer.c.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
