Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311595AbSDCVIl>; Wed, 3 Apr 2002 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDCVIc>; Wed, 3 Apr 2002 16:08:32 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:44627 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311642AbSDCVIS>;
	Wed, 3 Apr 2002 16:08:18 -0500
Date: Wed, 3 Apr 2002 22:05:44 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204031124170.3004-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0204032203520.1612-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Linus Torvalds wrote:

>
> On Wed, 3 Apr 2002, Tigran Aivazian wrote:
> >
> > Ok, but isn't it easier to rename _GPL -> _KERNEL (or _INTERNAL) if,
> > indeed, that is the meaning thereof? Then, in the future, one wouldn't
> > have to decide on a case by case basis like we had now (and appeal to
> > Caesar :) because the intention would be clear from the name?
>
> I agree, that is really the meaning of the _GPL thing, and it would
> probably also make people react less rabidly to the whole thing.
>
> 		Linus
>

Ok, so that would cover the 2.5.x (and future stable) kernels. Does
Marcelo also agree that it should be the case in the 2.4.x kernel?

Regards,
Tigran


