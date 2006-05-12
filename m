Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWELQlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWELQlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWELQkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:40:42 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30187 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932152AbWELQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:35 -0400
Date: Fri, 12 May 2006 09:40:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Kelly <jak@isp2dial.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Message-ID: <20060512164034.GK7646@smtp.west.cox.net>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net> <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr> <200605121619.k4CGJCtR004972@isp2dial.com> <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com> <200605121630.k4CGUuiU005025@isp2dial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605121630.k4CGUuiU005025@isp2dial.com>
Organization: Embedded Alley Solutions, Inc
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 12:31:02PM -0400, John Kelly wrote:
> On Fri, 12 May 2006 12:24:40 -0400 (EDT), Steven Rostedt
> <rostedt@goodmis.org> wrote:
> 
> >> >Sorry for falling in late but we can't do that.
> >> >Win 98 (95 too?) shared can not be mounted with CIFS, it requires SMBFS.
> 
> >> W98?  He's dead, Jim.
> 
> >huh, my wife has a laptop that she still uses that has w98 on it. And I do
> >use smbfs to sometimes communicate with it.
> 
> Users who need vintage features can use vintage kernels.  They haven't
> been pulled off the market.

Having a shiny new storage box in my house that just might need to talk
with old laptops and new laptops and so on doesn't exactly jive with
that.

Of course perhaps this will cause someone who does care about smbfs to
setup up to the plate and maintain it.

-- 
Tom Rini
