Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSE0QBe>; Mon, 27 May 2002 12:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316670AbSE0QBd>; Mon, 27 May 2002 12:01:33 -0400
Received: from pD952A637.dip.t-dialin.net ([217.82.166.55]:29872 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316667AbSE0QBd>; Mon, 27 May 2002 12:01:33 -0400
Date: Mon, 27 May 2002 10:01:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] gcc3 arch options 
In-Reply-To: <Pine.LNX.4.44.0205271030240.24699-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0205271000390.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 May 2002, Kai Germaschewski wrote:
> CFLAGS is initially defined with ':=', which, as opposed to '=' means to 
> evaluate directly and store the resulting string, so it should be fine. 
> 
> Even if it wasn't, only the evaluations from the top-level Makefile would
> cause the command to be executed, make will always pass down the evaluated 
> result to the subdir makes.
> 
> --Kai

I've had an evaluation; it does not. So nothing to worry about

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.

