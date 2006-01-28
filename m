Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWA1EJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWA1EJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWA1EJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:09:15 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:24211 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932065AbWA1EJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:09:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o/4nsWwRcOQUdJkxD6SOAdejuInSMAnWJhuhVImA+hr+kQo1CbN6rSUUQ+qdzZoRtw4tjd0gnxctHoRjHGpkrRUlZ7swX29IqNIu2F27ztrqTAT5+5uVE1sucs+5z1vTKs1daNCzpx4UGOcaafwDwBzxjpCEt7fY46RJKGvkc9Q=
Message-ID: <29495f1d0601272009t9838bbw38caa1c806c5ab98@mail.gmail.com>
Date: Fri, 27 Jan 2006 20:09:14 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/3] Fix overflow issues with sysctl values in centiseconds/seconds
Cc: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060127195539.6ffc3d3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DADB03.7080606@samwel.tk>
	 <20060127195539.6ffc3d3a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/06, Andrew Morton <akpm@osdl.org> wrote:
> Bart Samwel <bart@samwel.tk> wrote:
> >
> >  Here's a threesome of patches
> >
>
> All of which were space-stuffed by your (mozilla-derived) email client and
> hence are unusable by users of non-MS-wannabe email clients.  They may also
> be unusable by users of mozilla-based email clients, too - I don't know.
>
> As far as I know there's no way to prevent mailnews-derived mail clients
> from performing space-stuffing.  I've had a bug report in against it for at
> least two years and all they've done is fartarse around with it.

I think this thread claims that there is a way (although a PITA):
http://lkml.org/lkml/2005/12/27/191

I don't use TBird, personally, but Randy D. seemed satisfied with the
results in that thread.

> IOW: please switch mail clients or use text/plain attachments.

Also viable (and maybe preferred) solutions.

Thanks,
Nish
