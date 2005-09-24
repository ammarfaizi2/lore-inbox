Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVIXWf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVIXWf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 18:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVIXWf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 18:35:57 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:53686 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750775AbVIXWf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 18:35:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZgushK3xpOWWhyeN/mHObmheBXasvZMoRUpUqJZobje5RCnWdaCWiQzm7qYazlcH+g7Euz0g5ugIsp/wEPs7xLHgeNQrEdI9OHVhX6BU1xL8qQQSquy7WBsLgwov55lrCHeJV6pckBTcf9e88O6Eus560HRPWH5GcGAm0RiYA38=
Message-ID: <9a874849050924153565cdc2b8@mail.gmail.com>
Date: Sun, 25 Sep 2005 00:35:56 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: patrizio.bassi@gmail.com
Subject: Re: [BUG] alsa volume and settings not restored after suspend
Cc: "Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <4335909D.2070904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4335909D.2070904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> As topic.
>
> Suspend works perfectly, but after resume, no sound from audio card.
>
> i see application works, for example i see xmms equalizer working, but
> no sound,
> even if i change manually volume.
>
> only way is restarting the alsa init script. after that it works
> perfectly.
> not a critical bug, but may be very confortable to have registers
> setted properly.
>
[snip]

Have you tried talking to the ALSA people about this?

    http://www.alsa-project.org/mailing-lists.php
    alsa-devel@lists.sourceforge.net

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
