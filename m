Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUG1OjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUG1OjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUG1OjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:39:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63932 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267179AbUG1OjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:39:05 -0400
Date: Wed, 28 Jul 2004 10:38:19 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for Innovision DM-8401H
Message-ID: <20040728143819.GA8423@devserv.devel.redhat.com>
References: <20040728134910.GA8514@devserv.devel.redhat.com> <200407281610.54961.bzolnier@elka.pw.edu.pl> <20040728140846.GA23938@devserv.devel.redhat.com> <200407281634.53664.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407281634.53664.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 04:34:53PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > I asked you to compare Sil and ITE datasheets
> > > (as I don't have one for Sil0680).
> > >
> > > Have you done this?
> >
> > I don't have the ITE datasheet.
> google is your friend: "IT8212F .pdf"

Ok the 8212F is different. Similar enough that the si680 driver would happen
to work in a lot of cases but you are correct this patch should not go in.


