Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbTGAGRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbTGAGRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:17:00 -0400
Received: from angband.namesys.com ([212.16.7.85]:26861 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S266007AbTGAGQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:16:59 -0400
Date: Tue, 1 Jul 2003 10:31:20 +0400
From: Oleg Drokin <green@namesys.com>
To: Greg KH <greg@kroah.com>
Cc: martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030701063120.GB7998@namesys.com>
References: <20030630171033.GA27703@diamond.madduck.net> <20030630180002.GA25461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630180002.GA25461@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jun 30, 2003 at 11:00:02AM -0700, Greg KH wrote:

> > I am soon going to switch to UML for this kind of development...
> For USB development?  Ok...please send us the patches that get USB
> support working under UML as others have wanted to do this for quite
> some time :)

The patches are at http://jmcmechan.linuxdriven.net
2.4 seems to be working and 2.5 ones are a bit outdated.
Still this is probably a better start than no patches at all ;)

Bye,
    Oleg
