Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317456AbSGEOHJ>; Fri, 5 Jul 2002 10:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317455AbSGEOHI>; Fri, 5 Jul 2002 10:07:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19979 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317456AbSGEOHI>; Fri, 5 Jul 2002 10:07:08 -0400
Date: Fri, 5 Jul 2002 10:15:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kdev_val typo
In-Reply-To: <20020701225136.GB469@frodo>
Message-ID: <Pine.LNX.4.44.0207051014140.16528-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its already in.

Thanks anyway.

On Tue, 2 Jul 2002, Nathan Scott wrote:

> hi Marcelo,
>
> There's a missing brace in the kdev_val() 2.5 compatibility macro
> which someone has added into 2.4.19-rc1, making the macro useless.
> Here's the trivial fix, in case noone else has sent it along yet.

