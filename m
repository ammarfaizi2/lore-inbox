Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVCIW5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVCIW5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVCIW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:56:34 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:43411 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262472AbVCIWX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:23:56 -0500
Date: Thu, 10 Mar 2005 09:22:32 +1100
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-ac1
Message-ID: <20050309222232.GH1811@zip.com.au>
References: <1110231261.3116.90.camel@localhost.localdomain> <20050309072646.GG1811@zip.com.au> <58cb370e05030908267f0fadbe@mail.gmail.com> <1110386321.3116.196.camel@localhost.localdomain> <58cb370e050309084374f93a71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050309084374f93a71@mail.gmail.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 05:43:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Wed, 09 Mar 2005 16:38:43 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Mer, 2005-03-09 at 16:26, Bartlomiej Zolnierkiewicz wrote:
> > > It can be merged if somebody fix it to always force controller into
> > > non-RAID mode and remove RAID mode support (which currently
> > > does nothing more besides complicating the driver and making special
> > > commands unusable).
> > 
> > Incorrect
> 
> Very helpful

Argh! Ok. I guess I shouldn't've just bought the card based on this
driver then so that I could better debug my problems with my promise
cards. 8(

-- 
    Red herrings strewn hither and yon.
