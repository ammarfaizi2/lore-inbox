Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVARUzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVARUzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVARUzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:55:16 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:22387 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261418AbVARUzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:55:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IBhpj1MHL3oQkMjFE/+W8a4FVvYFObVOoxrNejM2eq4iDPZSUMZi9u8NbqF73aAdFBtdqMESoIjwRVATqu/gwgB8l17MbbyeBctHZXKVz/KxsxC3X5nbsbCKMH3/BrK0o+Op7FhxGSUNG24OQ7I1+o2KZBpjW/U0xR/rELVLOpc=
Message-ID: <58cb370e050118125536c17538@mail.gmail.com>
Date: Tue, 18 Jan 2005 21:55:09 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: iswraid and 2.4.x?
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20050118195621.15879.qmail@web30202.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED56B5.8000603@pobox.com>
	 <20050118195621.15879.qmail@web30202.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Jan 2005 11:56:21 -0800 (PST), Martins Krikis
<mkrikis@yahoo.com> wrote:
> --- Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Check your inbox from months ago ;-)  AFAICS his current version
> > addresses all the comments from Alan and myself, from when it hit
> > lkml 6
> > months(?) ago...
> >
> > I'll give it another quick lookover though, sure.
> 
> Jeff,
> 
> As long as 2.4.30 is planned at all, I have no more
> worries for the moment. But if so, then please don't
> waste your time looking over the current version. In
> about a week there should really be another one out.
> It will add RAID10, and get rid of the "claim disks
> for RAID" mis-feature. I'll let everybody know, of course.

I'm just curious.  Is there already a possibility to use
RAID10 metadata in 2.6.x kernels?

Thanks,
Bartlomiej
