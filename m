Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUC2TLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUC2TLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:11:09 -0500
Received: from mail.cyclades.com ([64.186.161.6]:24292 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263091AbUC2TLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:11:06 -0500
Date: Mon, 29 Mar 2004 15:54:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hasso Tepper <hasso@estpak.ee>
Cc: Phil Oester <kernel@linuxace.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       dlstevens@ibm.com, davem@redhat.com
Subject: Re: Kernel panic in 2.4.25
Message-ID: <20040329185414.GB23917@logos.cnet>
References: <200403260035.09821.hasso@estpak.ee> <200403282033.16204.hasso@estpak.ee> <20040328182522.GA22382@linuxace.com> <200403282217.54539.hasso@estpak.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403282217.54539.hasso@estpak.ee>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IIRC a similar problem was in v2.6.

I'll dig it up.

On Sun, Mar 28, 2004 at 10:17:54PM +0300, Hasso Tepper wrote:
> Phil Oester wrote:
> > Do you have CONFIG_IP_MULTICAST enabled in your .config?
> 
> Yes.
> 
> > I don't, and a couple of the changes in this changeset depend upon
> > it. 
> >
> > I also run ospfd, so maybe you've hit upon something here...cc'ing
> > linux-net for comment
