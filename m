Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCWBYT>; Fri, 22 Mar 2002 20:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSCWBXK>; Fri, 22 Mar 2002 20:23:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293181AbSCWBPN>;
	Fri, 22 Mar 2002 20:15:13 -0500
Date: Fri, 22 Mar 2002 18:42:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Kim <john@larvalstage.com>
Cc: lkml <linux-kernel@vger.kernel.org>, marcelo@connectiva.com.br,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] trivial broken compile fixes for 2.4.19-pre4
In-Reply-To: <20020321022855.4788C23BAA@larvalstage.com>
Message-ID: <Pine.LNX.4.21.0203221841040.10969-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Mar 2002, John Kim wrote:

> Marcelo and Alan,
> 
> This patch fixes trivial syntax errors due to missing comment open or
> close or one too many comment open or close.  It will fix some compile
> errors as a result.  It should apply cleanly to 2.4.19-pre4.  Thanks.

John,

dma-arc.c and ecma_167.h hunks did not apply cleanly.

The other ones I've merged. 

