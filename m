Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSDBAaf>; Mon, 1 Apr 2002 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDBAaQ>; Mon, 1 Apr 2002 19:30:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36619 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293119AbSDBAaK>; Mon, 1 Apr 2002 19:30:10 -0500
Date: Mon, 1 Apr 2002 20:25:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <Pine.LNX.4.10.10204012036030.283-100000@mikeg.wen-online.de>
Message-ID: <Pine.LNX.4.21.0204012024440.8540-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Apr 2002, Mike Galbraith wrote:

<snip>

> It's the buffer.c changes (the ones I'm most interested in:) that are
> causing my disk woes.  They look like they're in right, but are causing
> bad (synchronous) IO behavior for some reason.  I have tomorrow yet to
> figure it out.

Just to make sure: You mean the buffer.c changes alone (pre4 -> pre5) are
causing bad synchronous IO behaviour for you ? 


