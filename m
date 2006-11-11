Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424513AbWKKKcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424513AbWKKKcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 05:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424515AbWKKKcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 05:32:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:36502 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1424513AbWKKKci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 05:32:38 -0500
X-Originating-Ip: 72.57.81.197
Date: Sat, 11 Nov 2006 05:30:13 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: where can I select INPUT?
In-Reply-To: <200611111325.02749.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.64.0611110528350.2872@localhost.localdomain>
References: <200611111325.02749.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006, Andrey Borzenkov wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Neither in menuconfig nor in xconfig do I see any place to actually select
> INPUT. Help text suggests that it is a) selectable b) it can be made modules.
> I do not have either option. Here what I see in menuconfig if I go into Input
> device support:
>
>     --- Generic input layer (needed for keyboard, mouse, ...)
>     < >   Support for memoryless force-feedback devices
>     ---   Userland interfaces
>
> as you see there is no check box for INPUT itself.

... snip ...

somewhat off-topic, but when one has questions about oddities in the
configuration process, is it more appropriate to ask on *this* list,
or on the kbuild-devel list?

only two minutes ago, i posted this kind of question to kbuild-devel,
but now i'm wondering if i sent it to the wrong place.  thoughts?

rday
