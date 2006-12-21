Return-Path: <linux-kernel-owner+w=401wt.eu-S1423064AbWLUUS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423064AbWLUUS7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423072AbWLUUS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:18:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50124 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423064AbWLUUS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:18:58 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Scott Preece" <sepreece@gmail.com>
Cc: "Tomas Carnecky" <tom@dbservice.com>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "James Porter" <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
References: <loom.20061215T220806-362@post.gmane.org>
	<20061215220117.GA24819@martell.zuzino.mipt.ru>
	<4583527D.4000903@dbservice.com>
	<m13b7ds25w.fsf@ebiederm.dsl.xmission.com>
	<7b69d1470612210833k79c93617nba96dbc717113723@mail.gmail.com>
Date: Thu, 21 Dec 2006 13:18:32 -0700
In-Reply-To: <7b69d1470612210833k79c93617nba96dbc717113723@mail.gmail.com>
	(Scott Preece's message of "Thu, 21 Dec 2006 10:33:10 -0600")
Message-ID: <m1hcvpngtj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Scott Preece" <sepreece@gmail.com> writes:

> Which is more rude:
> (a) "Thank you for requesting a driver to support our hardware on
> Linux. Unfortunately, we don't have time either to provide such a
> driver or write the documentation that would allow you do so. The
> Linux market is not big enough to justify the work, and as a result we
> cannot offer you any support.", or
>
> (b) "Thank you for requesting a driver to support our hardware on
> Linux. Unfortunately, we don't have time either to provide such a
> driver or write the documentation that would allow you do so. The
> Linux market is not big enough to justify the legal and technical
> expense involved. However, we can provide you with this binary driver
> that we believe will allow you to use the hardware in your system,
> just as we provide binary drivers for other hardware platforms."

But as it happens that driver does not work for a large segment
percentage of linux users who potentially could place the card in
their system.  Did that driver support all 23 architectures?

> You say "It's rude to not play by our rules". They say "It's rude of
> you to expect us to change our business model to support your niche
> market differently from the way we support everyone else." Neither is
> wrong...

Every market is different, and you have to different things in
different markets.  It is close to incompetent not to acknowledge
the fact that rules are different in different markets and different
places.  That is one of the reasons why people try to harmonize laws
so there is not too much of this going on.

Usually it is also the case that binary vs source release does nothing
to a hardware manufacturers business model they sell hardware after
all, and usually having a helping hand in writing the necessary
software and making it work (the source release) is a plus for the
hardware manufacturer.

The difference is that we don't expect the hardware manufactures to do
anything we only hope they will support linux.  Once they support
linux we do expect they will play well with others and if they don't
then it is rude.

Please none of this amoral Neither is wrong crap.

Eric
