Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVCDNL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVCDNL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVCDNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:07:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:23424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262914AbVCDNGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:06:04 -0500
Date: Fri, 4 Mar 2005 05:05:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304050526.16b25b1a.akpm@osdl.org>
In-Reply-To: <1109940685.26799.18.camel@localhost.localdomain>
References: <42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<1109894511.21781.73.camel@localhost.localdomain>
	<20050303182820.46bd07a5.akpm@osdl.org>
	<1109933804.26799.11.camel@localhost.localdomain>
	<20050304032820.7e3cb06c.akpm@osdl.org>
	<1109940685.26799.18.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2005-03-04 at 11:28, Andrew Morton wrote:
> > I think you're assuming that 2.6.x.y will have larger scope than is intended.
> 
> The examples I gave for remap_vm_area and exec are both from real world
> "gosh look I am root isn't that fun" type security holes. If that is
> outside the scope of 2.6.x.y then you need to go back to the drawing
> board.

Well *obviously* things like that are in scope.

It's hardly likely that "maintainers will forget the backport" in that
case, is it?

