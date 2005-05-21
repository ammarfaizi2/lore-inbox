Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVEUFK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVEUFK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 01:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEUFKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 01:10:25 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39687 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261665AbVEUFKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 01:10:15 -0400
Date: Sat, 21 May 2005 07:12:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Timur Tabi <timur.tabi@ammasso.com>, Christopher Li <lkml@chrisli.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
Message-ID: <20050521051217.GA8191@mars.ravnborg.org>
References: <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com> <20050518182250.GB8130@mars.ravnborg.org> <428B8809.8060406@ammasso.com> <20050520193706.GA8225@mars.ravnborg.org> <20050520234353.GM22946@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520234353.GM22946@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 04:43:53PM -0700, Joel Becker wrote:
> On Fri, May 20, 2005 at 09:37:06PM +0200, Sam Ravnborg wrote:
> > For both kernel 2.4 and 2.6 you can split up your makefile like this:
> > makefile <= all the external modules specific part
> > Makefile <= the kbuild specific part
> 
> 	You could also use our fake-2.6-kbuild-for-2.4 makefile,
> retrievable via:
> 
> svn cat -r 2205 http://oss.oracle.com/projects/ocfs2/src/trunk/Kbuild-24.make

$ which svn
which: no svn in (/bin:/usr/bin:/.....)

Care to post a copy?

	Sam
