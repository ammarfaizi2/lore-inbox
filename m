Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVAPR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVAPR0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVAPR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:26:36 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:59288 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262550AbVAPR0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:26:32 -0500
Date: Sun, 16 Jan 2005 18:26:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: changing local version requires full rebuild
Message-ID: <20050116172647.GA3306@mars.ravnborg.org>
Mail-Followup-To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <20050116152242.GA4537@mellanox.co.il> <20050116161622.GC3090@mars.ravnborg.org> <20050116162816.GA4715@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116162816.GA4715@mellanox.co.il>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 
> > Do you use "echo -mylocalver > localversion" to change the local version?
> > 
> > 	Sam
> 
> No, I do makemenuconfig to edit the version. Is that right?

That is fine too.
When building - do you use separate output dir?

	Sam
