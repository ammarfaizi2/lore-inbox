Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVBYAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVBYAAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVBYAAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:00:06 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:40206 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262559AbVBXXvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:51:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hg/mq2gEfQ71PpGMFdv2iMLYECbAh9v1pge9ppiDPf/Osx8ePtS0Z7wrAz0J1KUiNy5Gw8yy3GfOa2yEWabeS3wVFEgsMsghrdV3viWb5POdwyYuVLn6/e9OhsmTZVcZF87LCPkx89yfCOu0j3qpZOdGRuWcvZLdjmfQcllveqk=
Message-ID: <29495f1d050224155136fa4b2d@mail.gmail.com>
Date: Thu, 24 Feb 2005 15:51:36 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.11-rc4-RT-V0.7.39-02 kernel BUG
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <38468.192.168.1.5.1109286369.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <40114.195.245.190.93.1109155418.squirrel@195.245.190.93>
	 <421C8CB4.5060605@tiscali.de>
	 <16103.195.245.190.94.1109251064.squirrel@195.245.190.94>
	 <38468.192.168.1.5.1109286369.squirrel@192.168.1.5>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 23:06:09 -0000 (WET), Rui Nuno Capela
<rncbc@rncbc.org> wrote:
> > Matthias-Christian wrote:
> >>
> >> Hi!
> >> The first bug is in the usbb ohci module (report it to
> >> http://buzilla.kernel.org and its Maintainers). The second one is
> >> caused by the first one.
> >>
> >
> > Done.
> >
> > Bugzilla bug #4247:
> >   http://bugzilla.kernel.org/show_bug.cgi?id=4247
> >
> 
> And this was the response:
> 
> greg@kroah.com changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>              Status|NEW                         |REJECTED
>          Resolution|                            |INVALID
> 
> ------- Additional Comments From greg@kroah.com  2005-02-24 11:11 -------
> As you are using Ingo's patches, please post this to him, in an email, not
> on here.
> 
> Now what?

Reproduce the bug in a mainline kernel or do as Greg asked and have
Ingo take a look.

Thanks,
Nish
