Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVG0WtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVG0WtC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVG0WrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:47:19 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:63892 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262125AbVG0U1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:27:37 -0400
Date: Wed, 27 Jul 2005 22:27:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
Message-ID: <20050727202757.GB31180@mars.ravnborg.org>
References: <1121465068l.13352l.0l@werewolf.able.es> <1121465683l.13352l.5l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121465683l.13352l.5l@werewolf.able.es>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
> 
> On 07.16, J.A. Magallon wrote:
> > 
> > On 07.15, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > > 
> 
> This time I did not break anything... and they shut up gcc4 ;)

I have applied it to my tree. There still is a lot left when I compile
with -Wsign-compare.

	Sam
