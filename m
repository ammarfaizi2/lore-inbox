Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTIPXfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbTIPXfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:35:42 -0400
Received: from karnickel.4msp.de ([217.6.190.222]:19718 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S262531AbTIPXfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:35:41 -0400
Date: Wed, 17 Sep 2003 01:29:57 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: edouardino@ifrance.com, Bernhard Rosenkraenzer <bero@arklinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre4-pac1
Message-ID: <20030916232957.GA6216@debian.franken.de>
References: <Pine.LNX.4.56.0309151411010.14486@dot.kde.org> <wazza.87znh6t891.fsf@message.id> <1063665253.8257.27.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063665253.8257.27.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 11:34:14PM +0100, Alan Cox wrote:
> On Llu, 2003-09-15 at 15:51, edouardino@ifrance.com wrote:
> > Hi,
> > 
> > Could you send me the Device Mapper patch you used ?
> > Or could you make -pac available as splitted patches too ?
> > I fact I'd like to use a recent dm.
> 
> Its the bits in drivers/md and include/linux/dm* - easy to split out.
> It is quite old. The Sistina guys have been promising me an update for
> some time but I guess 2.6 is far more important

The latest version I know about is at:

http://people.sistina.com/~thornber/patches/2.4-stable/2.4.22/
