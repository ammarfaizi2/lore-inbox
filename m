Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGAOAt>; Mon, 1 Jul 2002 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSGAOAs>; Mon, 1 Jul 2002 10:00:48 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:26118 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315539AbSGAOAr>; Mon, 1 Jul 2002 10:00:47 -0400
Date: Mon, 1 Jul 2002 18:02:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020701180252.A15288@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru> <20020701090353.B1957@tricia.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020701090353.B1957@tricia.dyndns.org>; from jlnance@intrex.net on Mon, Jul 01, 2002 at 09:03:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 09:03:53AM -0400, jlnance@intrex.net wrote:
> So how does Tru64 handle this?  It must have some way of knowing whether to
> mask the high bits or not.

No idea. Not sure if it handles this at all. Maybe you
just have to recompile.

> If the comment above is correct then this patch
> breaks new Tru64 binaries.

Last time I checked Tru64 v5.0 and above binaries didn't worked
under Linux for other reasons (missing libraries or something like that).

Ivan.
