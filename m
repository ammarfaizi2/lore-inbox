Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVCRPJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVCRPJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVCRPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:09:15 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:4259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261628AbVCRPIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:08:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Nldc+U+n3Z5z7FE+33fd2elSpYMZjC1R66ouOj3E9HSNYlY6FGD50P5O+e362IVPoaGS+tLOhPfpCHrztxTRSlS+yhD6H3MMvcgdRf1XsZ0I0J3b8EH2E1jAahn+0XaGTjbcEmbx/e6XvHxvg7NwHeM+N1eMRTRJ44k0mqxjPDQ=
Message-ID: <4f6c1bdf05031807086e5e92f7@mail.gmail.com>
Date: Fri, 18 Mar 2005 20:38:51 +0530
From: Hong Kong Phoey <hongkongphoey@gmail.com>
Reply-To: Hong Kong Phoey <hongkongphoey@gmail.com>
To: Stelian Pop <stelian@popies.net>, lm@bitmover.com, andersen@codepoet.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
In-Reply-To: <20050318142124.GA3333@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050317144522.GK22936@hottah.alcove-fr>
	 <20050318001053.GA23358@bitmover.com>
	 <20050318055040.GA16780@codepoet.org>
	 <20050318063853.GA30603@bitmover.com>
	 <20050318090047.GA12314@sd291.sivit.org>
	 <20050318141345.GA2227@bitmover.com>
	 <20050318142124.GA3333@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 15:21:25 +0100, Stelian Pop <stelian@popies.net> wrote:
> On Fri, Mar 18, 2005 at 06:13:45AM -0800, Larry McVoy wrote:
> 
> > On Fri, Mar 18, 2005 at 10:00:49AM +0100, Stelian Pop wrote:
> > > On Thu, Mar 17, 2005 at 10:38:53PM -0800, Larry McVoy wrote:
> > >
> > > > Hey, it's open source, I'm hoping that people will take that code and
> > > > evolve it do whatever they need.  We're willing to do what we can on
> > > > this end if people need protocol changes to support new features,
> > > > time permitting.  Think of that code as a prototype.  It's really
> > > > simple, you can hack it trivially.
> > >
> > >     ------------
> > >     if (strncmp("bk://", p, 5)) return (1);
> > >     ------------
> > >
> > > Any chance this could be made to work over http ?
> >
> > I don't see why not.  It will take some hacking though.  Can you live
> > without it for a bit or is it urgent?
> 
> It's not urgent at all...
> 

IMHO, BKCVS is just fine, what's broken is your head.

> Thanks.
> 
> Stelian.
> --
> Stelian Pop <stelian@popies.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
