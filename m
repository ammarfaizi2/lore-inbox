Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVE1Lio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVE1Lio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVE1Lin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:38:43 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:45071 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262708AbVE1Lii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:38:38 -0400
To: hch@infradead.org
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20050528105249.GB20488@infradead.org> (message from Christoph
	Hellwig on Sat, 28 May 2005 11:52:49 +0100)
Subject: Re: FUSE inclusion?
References: <E1DbGol-0006tE-00@dorka.pomaz.szeredi.hu> <20050528102559.GA20153@infradead.org> <E1DbyoI-00088C-00@dorka.pomaz.szeredi.hu> <20050528105249.GB20488@infradead.org>
Message-Id: <E1Dbze1-0008CP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 28 May 2005 13:38:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just because it's documented it's not any better.

Agreed.

> It's still the horrible hack it was at the beginning and no amount
> of discussion or documentation will change that.

Well, the discussion did help.  It helped me understand better why
this is necessary, and not only necessary, but basically the _only_
way to solve this problem.  And the documentation is there so that
others can understand too.

Did you actually read it?

Miklos
