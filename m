Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTAFQMl>; Mon, 6 Jan 2003 11:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTAFQMl>; Mon, 6 Jan 2003 11:12:41 -0500
Received: from enchanter.real-time.com ([208.20.202.11]:38158 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S267011AbTAFQMk>; Mon, 6 Jan 2003 11:12:40 -0500
Date: Mon, 6 Jan 2003 10:21:04 -0600
From: Carl Wilhelm Soderstrom <chrome@real-time.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dmitry Volkoff <vdb@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs corruption with 2.4.20 IDE+md+LVM
Message-ID: <20030106102103.A8123@real-time.com>
References: <20030106021412.GA3993@server1> <20030105224909.C24674@real-time.com> <1041865322.17472.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1041865322.17472.13.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 06, 2003 at 03:02:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 03:02:02PM +0000, Alan Cox wrote:
> You are reporting problems in 2.4.20. 2.4.20 doesn't have the revamped IDE...

I know. which is why I put that comment after the section of my mail
regarding md bugs in 2.4.21

> The IDE is getting updated because
> 
> - Lots of new controllers dont work with the old code
> - Lots of LBA48 problems exist with the older code
> - SATA is right out with the older code
> - Several existing controllers have weird bugs with the older code
> 
> I'd much prefer we didn't have to update the IDE too 8)

ok. I didn't see an extensive discussion of this on any of the kernel-digest
forums (kerneltrap, kernel traffic). 
I'll trust that you're doing the right thing, and try to avoid stepping in
any other flamebait. ;)

Carl Soderstrom.
-- 
Systems Administrator
Real-Time Enterprises
www.real-time.com
