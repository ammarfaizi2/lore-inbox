Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSE3Ska>; Thu, 30 May 2002 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSE3Ska>; Thu, 30 May 2002 14:40:30 -0400
Received: from www.transvirtual.com ([206.14.214.140]:4365 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316821AbSE3Sk3>; Thu, 30 May 2002 14:40:29 -0400
Date: Thu, 30 May 2002 11:40:14 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Andrew Pam <xanni@glasswings.com.au>
cc: Hannu Mallat <hmallat@cc.hut.fi>,
        James Simmons <jsimmons@users.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 3dfx framebuffer driver borked in 2.5.19 kernel
In-Reply-To: <20020530165031.GA18544@kira.glasswings.com.au>
Message-ID: <Pine.LNX.4.10.10205301139260.9282-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With the port to the new fbdev interface in kernel
> 2.5.19 the system now only displays a few unchanging coloured pixels
> on the first line of the screen.  The rest of the screen remains black
> until X11 starts.  I am using append="video=tdfx:1024x768" in LILO.

I'm tracking down the bug you are experiencing. Almost done. 

