Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272412AbTHNPou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272432AbTHNPou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:44:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:1494 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272412AbTHNPot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:44:49 -0400
Date: Thu, 14 Aug 2003 08:37:03 -0700
From: Greg KH <greg@kroah.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm2: Badness in class_dev_release at drivers/base/class.c
Message-ID: <20030814153703.GA13769@kroah.com>
References: <1060803513.1221.2.camel@teapot.felipe-alfaro.com> <20030813234220.GB7863@kroah.com> <Pine.LNX.4.51.0308140900260.11099@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0308140900260.11099@dns.toxicfilms.tv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:01:56AM +0200, Maciej Soltysiak wrote:
> > I have a fix for this in my tree, it will get sent to Linus in a few
> > days.
> >
> > thanks for the report.
> Great if so, it would resolve bugzilla #1094 & #700.
> Both reported by me.

No, both of those are scsi bugs/issues, which have nothing to do with
this report/fix.  Sorry.  Your bugs should be fixed by some patches
already in the scsi tree, which haven't made it into Linus's yet.

thanks,

greg k-h
