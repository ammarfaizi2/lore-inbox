Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVKVQZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVKVQZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKVQZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:25:12 -0500
Received: from havoc.gtf.org ([69.61.125.42]:23686 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751315AbVKVQZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:25:10 -0500
Date: Tue, 22 Nov 2005 11:25:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122162506.GA32684@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43834400.3040506@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:14:56PM +0200, Avi Kivity wrote:
> You exaggerate. Windows drivers work well enough in Windows (or so I 
> presume). One just has to implement the environment these drivers 
> expect, very carefully.

I exaggerate nothing -- we have real world experience with ndiswrapper
and similar software, which is exactly the same model you proposed, is
exactly the same model that has created all sorts of technical, legal,
and political problems.

Dumb with a capital 'D'.

	Jeff

