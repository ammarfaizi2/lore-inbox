Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWBJUGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWBJUGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWBJUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:06:00 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:65401 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751367AbWBJUGA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:06:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUprqkkDIG4Sdqw7q78Oc1jq+yfQLRmXCc6SYkawSLviiLQtxWTw8R24UZsXIdgU4lCnkFv1jss9xjdAn4oVNKFePlPInQZFDuYSl8EcSfzhSp2vj9Jd9XRnxAai+C0b+YIYvC2GDj2ECgJ0UYYbVOLFmWuPfG7ZC/LzY0fBgQA=
Message-ID: <2cd57c900602101205s7a884ce2w@mail.gmail.com>
Date: Sat, 11 Feb 2006 04:05:58 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc2-mm1
Cc: linux-kernel@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20060210112530.540fec62.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207220627.345107c3.akpm@osdl.org>
	 <2cd57c900602101017l61dd9ddbh@mail.gmail.com>
	 <20060210112530.540fec62.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/2/11, Andrew Morton <akpm@osdl.org>:
> Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> >
> > 2006/2/8, Andrew Morton <akpm@osdl.org>:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> > >
> > >
> > > - Should also be available at:
> > >
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
> > >
> > >   browseable at:
> > >
> > >         ftp://ftp.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
> > >
> > >   thanks to a script which Matthias Urlichs <smurf@smurf.noris.de> has
> > >   prepared.  I haven't tried this, so please let us know how it goes.
> >
> > The master branch seems not correct. It should be v2.6.16-rc2-mm1, but
> > it is v2.6.13-rc4-mm1 or something.

"v2.6.15-mm3" actually.

> >
>
> There is a 2.6.16-rc2-mm1 tag in there.  Perhaps Matthias could describe
> how things are organised, recommendations for how people should use that
> tree?
>

We should use "tags" for particular releases, and just one "master" branch.
--
Coywolf Qi Hunt
