Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316977AbSFABqp>; Fri, 31 May 2002 21:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316978AbSFABqo>; Fri, 31 May 2002 21:46:44 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42896 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316977AbSFABqn>; Fri, 31 May 2002 21:46:43 -0400
Date: Fri, 31 May 2002 20:46:42 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [PATCH] kbuild: Remove 2048 symbol limit in tkparse
In-Reply-To: <20020531224151.A13857@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0205312045220.18762-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Sam Ravnborg wrote:

> tkparse limit the number of symbols to 2048.
> This patch makes the array dynamic avoiding this problem in the future.
> The problem showed up in one of the powerpc tree's.

Thanks, I'll look at this (and the other patches) and submit it to Linus
(assuming I don't find anything wrong with it), if he didn't already merge
it.

--Kai


