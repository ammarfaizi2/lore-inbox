Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFDIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFDIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFDIku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:40:50 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:13375 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261305AbVFDIkl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:40:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PA4nriGNJchqVZQag6hy3aY649G16aV58zA093xGy0yWA7WEGhY4YXt/HhS1uHxeg3IXrvR7+iUte89DOKAk0CybGVVwSeaZz915ezv0Pdgp08LweFhbTHNPgum3RJYj11BHiuidaiaJnzN1DT8JgjI/qBBBmPQLxvAWV/fJQNk=
Message-ID: <21d7e99705060401405cfd5a11@mail.gmail.com>
Date: Sat, 4 Jun 2005 18:40:40 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [doc][git] playing with git, and netdev/libata-dev trees
Cc: Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42955DF7.4000805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42955DF7.4000805@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When I merge a patch for drivers/net/forcedeth.c, I merge it into a
> brand new 'forcedeth' repository, a peer to the 40+ other such
> repository.  Under BitKeeper, I made these repositories available merged
> together into one big "netdev-2.6" repository because it was too time
> consuming to make the individual 50+ trees publicly available.  With
> git, developers have direct access to the individual trees.
> 
> I thought I would write up a quick guide describing how to mess around
> with the netdev and libata-dev trees, and with git in general.
> 

Thanks for this, I'm starting to get up to speed on git now...

Two questions,

1. when you want to publish your tree what do you do? just rsync it
onto kernel.org?
2. When you are taking things from your queue for Linus do you create
another tree and merge your branches into it or what?

Dave.
