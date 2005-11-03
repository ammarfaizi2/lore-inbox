Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVKCWsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKCWsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVKCWsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:48:03 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:10431 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932225AbVKCWsB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:48:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BQseBXGW5jPYOrOQFK/Ix4mKHC3v2CnAhTgmcq0qXJfqbqhseVlD2u3B0OzYv/W629yuWz4ziPLJ0sM7Q93u6v/UMSS2iHqDjpzp+vQWGCgyvqvRvPBwaZQXw0BrJbhLs4exxVCKs3EPCt4dQW8rJT4jniSuAKFEkv/CdFBOX9I=
Message-ID: <58cb370e0511031448y19e07624xc04e4e91f08edabf@mail.gmail.com>
Date: Thu, 3 Nov 2005 23:48:00 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <m3br11z7ps.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
	 <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
	 <m3br11z7ps.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:
>
> > Do you think that libata is currently so much better wrt to PATA
> > hot-(un)plug support?
>
> For me? Libata works. Old IDE driver doesn't work. To be honest, haven't
> checked since switched to libata, this problem might be fixed now.

Are you talking about PATA here?

If no there is no point in further discussion (libata is the right choice)...

Bartlomiej
