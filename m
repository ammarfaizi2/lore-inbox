Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSKFPMf>; Wed, 6 Nov 2002 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265704AbSKFPMf>; Wed, 6 Nov 2002 10:12:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:4843 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265700AbSKFPMU>; Wed, 6 Nov 2002 10:12:20 -0500
Date: Wed, 6 Nov 2002 10:19:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: linux-2.4 cset 1.736.3.2 breaks USB hubs , deadlock
In-Reply-To: <20021101222852.A5717@suse.de>
Message-ID: <Pine.LNX.4.44L.0211061019000.27268-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Nov 2002, Olaf Hering wrote:

> What shoud this patch fix?
>
> It locks up my iBook when attaching an Apple USB keyboard. Other people
> reported similar hangs.
> Please revert it or find a better solution for 2.4.20.

Olaf,

I already reverted it. Thanks.

