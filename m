Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVKVOa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVKVOa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVKVOa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:30:58 -0500
Received: from havoc.gtf.org ([69.61.125.42]:14723 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964950AbVKVOa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:30:57 -0500
Date: Tue, 22 Nov 2005 09:30:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Neil Brown <neilb@suse.de>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122143055.GC24997@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <17282.39560.978065.606788@cse.unsw.edu.au> <200511221007.12833.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511221007.12833.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:07:12AM +0200, Denis Vlasenko wrote:
> Historically hackers were not too good at raising funds.
> 
> Maybe we should use stuff which we are good at? Forcedeth
> is a nice precedent. 2d and especially 3d engines
> may be significantly harder to reverse engineer,
> but people can scale rather nicely, as kernel development shows. ;)
> 
> Then write specs from gained knowledge and put it on a web page.

Yes, IMO this is the only realistic path, without cooperation from
ATI/NVIDIA.

This is why I dislike the ATI r300 rev-eng effort:  I cannot find any
"Chinese wall":  one team rev-engs the hardware and writes a doc.
Another team writes the drivers from the docs.

	Jeff



