Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVHTRhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVHTRhG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 13:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVHTRhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 13:37:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:60764 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932611AbVHTRhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 13:37:03 -0400
Date: Sat, 20 Aug 2005 19:37:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Martin Waitz <tali@admingilde.org>
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Message-ID: <20050820173706.GA11079@mars.ravnborg.org>
References: <20050819213447.GA9538@localhost.localdomain> <84144f02050819144660238be4@mail.gmail.com> <20050819232340.GB9538@localhost.localdomain> <20050820074106.GA15162@mars.ravnborg.org> <20050820091941.GA15936@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820091941.GA15936@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 11:19:41AM +0200, Stephane Wirtel wrote:
> Le Saturday 20 August 2005 a 09:08, Sam Ravnborg ecrivait: 
> > > 
> > > Ok, with scripts/kernel-doc, I can produce some html files containing 
> > > the functions' documentation.
> > > 
> > > make pdfdocs or others targets don't work :|
> > 
> > You probarly need some additional packages.
> > But it's not easy to help you with no log of what happened.
> Yes, sorry, 
> 
> Kernel : 2.6.12 from the git repository of Linus.
> 
> In make_docs.log.tar.bz2, you can find log files from make htmldocs,
> make psdocs and make pdfdocs.

>From your log-files I could not see what went wrong. It seems to be
error in the generated files.
Maybe Martin can help - Martin?

	Sam
