Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316515AbSEOW4V>; Wed, 15 May 2002 18:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316516AbSEOW4U>; Wed, 15 May 2002 18:56:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:3459 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316515AbSEOW4T>; Wed, 15 May 2002 18:56:19 -0400
Date: Wed, 15 May 2002 17:56:18 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Larry McVoy <lm@bitmover.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020515153016.H13795@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0205151752400.1802-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Larry McVoy wrote:

> bk park		# saves work as a patch
> bk pull
> bk unpark	# restores the patch
> 
> park/unpark are undocumented because they puke when there are patch rejects.
> If we document them, then we have to explain to people what to do when there
> are patch rejects, and if you need that explanation, we probably can't help
> you.  You guys all grok patch rejects, so try park/unpark.

So what's the undocumented option to turn off consistency checks? ;-)

I understand that they exist for a reason, etc, but I'd really like to 
have the option to switch them off (and suffer the consequences all by 
myself)

--Kai


