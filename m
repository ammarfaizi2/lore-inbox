Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVARVSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVARVSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVARVSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:18:17 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:59930 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261429AbVARVRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:17:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YZXCSooOwQoMnLACMP2hFZNDtoubTBAqM6i6zez7flq/m4xoPVVgmgYVR+ynqajL6nXXPFQF4soYAHBAFnda08uB1IXjx9Wa1hHa9LjPcA6iqmiLN5vMLrTUrER/NjLe8dlx+tRYLHkRgtnON0WSaE9VH/c4G2q2cZbru9ZgS+0=
Message-ID: <58cb370e05011813176078d62d@mail.gmail.com>
Date: Tue, 18 Jan 2005 22:17:44 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: iswraid and 2.4.x?
Cc: Martins Krikis <mkrikis@yahoo.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <41ED7C38.3080201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED56B5.8000603@pobox.com>
	 <20050118195621.15879.qmail@web30202.mail.mud.yahoo.com>
	 <58cb370e050118125536c17538@mail.gmail.com>
	 <41ED7C38.3080201@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 16:14:32 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > On Tue, 18 Jan 2005 11:56:21 -0800 (PST), Martins Krikis
> > <mkrikis@yahoo.com> wrote:
> >
> >>--- Jeff Garzik <jgarzik@pobox.com> wrote:
> >>
> >>
> >>>Check your inbox from months ago ;-)  AFAICS his current version
> >>>addresses all the comments from Alan and myself, from when it hit
> >>>lkml 6
> >>>months(?) ago...
> >>>
> >>>I'll give it another quick lookover though, sure.
> >>
> >>Jeff,
> >>
> >>As long as 2.4.30 is planned at all, I have no more
> >>worries for the moment. But if so, then please don't
> >>waste your time looking over the current version. In
> >>about a week there should really be another one out.
> >>It will add RAID10, and get rid of the "claim disks
> >>for RAID" mis-feature. I'll let everybody know, of course.
> >
> >
> > I'm just curious.  Is there already a possibility to use
> > RAID10 metadata in 2.6.x kernels?
> 
> Intel or 'md' metadata?

Intel
 
> You need dmraid to use the Intel proprietary format.  I'm not sure if it
> supports RAID10 yet, but it supports the other levels.

I know about other levels, I'm asking about RAID10.
