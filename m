Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJ2XtJ>; Tue, 29 Oct 2002 18:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJ2XtJ>; Tue, 29 Oct 2002 18:49:09 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:16768 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262067AbSJ2XtJ>;
	Tue, 29 Oct 2002 18:49:09 -0500
Date: Tue, 29 Oct 2002 17:55:31 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poll-related "scheduling while atomic", 2.5.44-mm6
Message-Id: <20021029175531.75c1db4e.arashi@arashi.yi.org>
In-Reply-To: <3DBF0958.F887DD69@digeo.com>
References: <20021029153719.4ebc4486.arashi@arashi.yi.org>
	<3DBF0958.F887DD69@digeo.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002 14:19:04 -0800
Andrew Morton <akpm@digeo.com> wrote:

> Matt Reppert wrote:
> > 
> > So my guess is somewhere between -mm5 and -mm6 we
> > screwed up the atomicity count.
> 
> Mine too.  I'll check it out, thanks.
> 
> Do you have preemption enabled?

Sure do.

Thanks,
Matt
