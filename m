Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVDDTov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDDTov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDDTov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:44:51 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:23337 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261323AbVDDTok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:44:40 -0400
X-ME-UUID: 20050404194435154.259901C00223@mwinf0512.wanadoo.fr
Date: Mon, 4 Apr 2005 21:41:24 +0200
To: md@Linux.IT, Greg KH <greg@kroah.com>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404194124.GA2131@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050404190518.GA17087@wonderland.linux.it>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:05:18PM +0200, Marco d'Itri wrote:
> On Apr 04, Greg KH <greg@kroah.com> wrote:
> 
> > What if we don't want to do so?  I know I personally posted a solution
> Then probably the extremists in Debian will manage to kill your driver,
> like they did with tg3 and others.

Nope, they were simply moved to non-free, as it should. I believe the package
is waiting for NEW processing, but i also believe that the dubious copyright
assignement will not allow the ftp-masters to let it pass into the archive,
since it *IS* a GPL violation, and thus i am doing this in order to solve that
problem.

> This sucks, yes.

Not really. Once the, post-sarge, transition is done, you just will have to
load the non-free .udeb from the non-free d-i archive, or install the module
package from non-free, and you won't even notice.

Sarge kernels are messed beyond recognition in this anyway, but they are
freezed so ...

Friendly,

Sven Luther

