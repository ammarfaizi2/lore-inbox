Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289544AbSAJQs4>; Thu, 10 Jan 2002 11:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289543AbSAJQsq>; Thu, 10 Jan 2002 11:48:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50186 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289539AbSAJQsl>;
	Thu, 10 Jan 2002 11:48:41 -0500
Date: Thu, 10 Jan 2002 14:48:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Rodrigo Souza de Castro <rcastro@ime.usp.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pager_daemon removal
In-Reply-To: <20020110143922.A12252@ime.usp.br>
Message-ID: <Pine.LNX.4.33L.0201101447130.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Rodrigo Souza de Castro wrote:
> On Thu, Jan 10, 2002 at 02:27:05PM -0200, Rik van Riel wrote:
> > On Thu, 10 Jan 2002, Rodrigo Souza de Castro wrote:
> >
> > > Comments?
> >
> > You're not allowed to renumber sysctl defines, it's ok
> > to remove the VM_PAGER_DAEMON thing, but the following
> > defines should stay the same number ...
>
> Oops, you are right, thanks. New patch follows.

Looks good to me ...

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

