Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293587AbSBZLkS>; Tue, 26 Feb 2002 06:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293579AbSBZLkJ>; Tue, 26 Feb 2002 06:40:09 -0500
Received: from mailer.zib.de ([130.73.108.11]:7828 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S293580AbSBZLjx>;
	Tue, 26 Feb 2002 06:39:53 -0500
Date: Tue, 26 Feb 2002 12:39:49 +0100
From: Sebastian Heidl <heidl@zib.de>
To: "David S. Miller" <davem@redhat.com>
Cc: nick@snowman.net, linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020226123949.C8471@csr-pc6.local>
Mail-Followup-To: Sebastian Heidl <heidl@zib.de>,
	"David S. Miller" <davem@redhat.com>, nick@snowman.net,
	linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
	linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202252243360.18586-100000@ns> <20020225.204022.62649663.davem@redhat.com> <20020226122205.B8471@csr-pc6.local> <20020226.032453.41634091.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020226.032453.41634091.davem@redhat.com>; from davem@redhat.com on Tue, Feb 26, 2002 at 03:24:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 03:24:53AM -0800, David S. Miller wrote:
>    From: Sebastian Heidl <heidl@zib.de>
>    Date: Tue, 26 Feb 2002 12:22:05 +0100
> 
>    I think these are 3C996-T. Is there any information about the
>    compatibility of TG3 to TG2 ?
> 
> Totally different chip, but there are subtle similarities all over
> the place.  Ie. if you knew how to program the tg2, or even were just
> familiar with the acenic driver, the tg3 stuff looks familiar.
That's what I noticed looking at tg3.c ;-)
I guess nobody was crazy enough yet to try to load a tg2-firmware on a tg3 ?
Only as there are some utils to build a customized firmware for the tg2.

just guessing wildly ;-)
_sh_

