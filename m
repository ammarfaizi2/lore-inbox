Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUAQUXm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUAQUXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:23:41 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:39306 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266177AbUAQUXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:23:40 -0500
Date: Sat, 17 Jan 2004 12:23:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Condor <condor@vereya.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 may be bug in prints.c:341
Message-ID: <20040117202324.GZ1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Condor <condor@vereya.net>, linux-kernel@vger.kernel.org
References: <00e201c3dd32$25bde0d0$8648493e@ixip.net> <20040117195151.GY1748@srv-lnx2600.matchmail.com> <010801c3dd37$1ff2ee20$8648493e@ixip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010801c3dd37$1ff2ee20$8648493e@ixip.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:18:25PM +0200, Condor wrote:
> 
> ----- Original Message ----- 
> From: "Mike Fedyk" <mfedyk@matchmail.com>
> To: "Condor" <condor@vereya.net>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Saturday, January 17, 2004 9:51 PM
> Subject: Re: 2.4.24 may be bug in prints.c:341
> 
> 
> > On Sat, Jan 17, 2004 at 09:42:46PM +0200, Condor wrote:
> > > Hello all,
> > >
> > > 1. My server stop work after trying to access hard drives.
> > > 2. My server have kernel panic when trying to access hard drives. I
> don't
> > > now what is the real problem,
> >
> > Did you run fsck on the filesystem?
> 
> Yes i run, but problem did'nt resolved. The problem is in hard drive, now
> disk is gone and may be every thing
> is work fine ...
> 

Did it show errors?  Did you try to fix them?  What commands did you run?

> >
> > You didn't run it through ksymoops...
> > -

You still didn't run the oops through ksymoops...
