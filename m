Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTKSK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbTKSK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:26:16 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:29092 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S263973AbTKSK0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:26:15 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: kernel.bkbits.net off the air
Date: Wed, 19 Nov 2003 10:26:13 +0000
User-Agent: KMail/1.5.4
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311190024.51548.andrew@walrond.org> <20031119003840.GA29668@nevyn.them.org>
In-Reply-To: <20031119003840.GA29668@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311191026.13198.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 Nov 2003 12:38 am, Daniel Jacobowitz wrote:
>
> Presumably because he's said several times that the bk2cvs gateway
> software is based on (and requires) the commercial version of bk.  Not
> to mention that the way it generates repositories isn't really
> compatible with this model.

I was (obviously?) assuming that the bk(d) was the commercial version, but I 
don't see how that would affect the client from being o/s?

And why is this different from bk2cvs? Because then I have to rsync the cvs 
repo with all the problems (discussed at length in this thread) of getting a 
coherent local copy of the repo.

I guess it all comes back to my wanting to host my (commercial and open-
source) public code repositories with bk, but have to guarantee 100% access 
to my 'users'. 99% Isn't good enough.

I'm not, Daniel, a FSF/GPL whiner, and do not appreciate being labelled as 
such.

Andrew Walrond

