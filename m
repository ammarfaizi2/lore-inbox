Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUFOTcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUFOTcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFOTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:32:41 -0400
Received: from pdbn-d9bb9ee6.pool.mediaWays.net ([217.187.158.230]:19974 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265875AbUFOTcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:32:22 -0400
Date: Tue, 15 Jun 2004 21:32:05 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Cesar Eduardo Barros <cesarb@nitnet.com.br>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040615193205.GA25131@citd.de>
References: <20040612011129.GD1967@flower.home.cesarb.net> <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br> <20040614224006.GD1961@flower.home.cesarb.net> <orfz8wabng.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orfz8wabng.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:01:23PM -0300, Alexandre Oliva wrote:
> On Jun 14, 2004, Cesar Eduardo Barros <cesarb@nitnet.com.br> wrote:
> 
> > The atime was never intended as an auditing feature (if it were, utimes
> > and related functions would be root only).
> 
> But utimes updates the inode modification time, so you can still tell
> something happened to the file.

No.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

