Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSEMJHI>; Mon, 13 May 2002 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSEMJHH>; Mon, 13 May 2002 05:07:07 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:18 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310190AbSEMJHH>;
	Mon, 13 May 2002 05:07:07 -0400
Date: Mon, 13 May 2002 01:06:22 -0700
From: Greg KH <greg@kroah.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513080621.GD8838@kroah.com>
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <20020513015724.I14698@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Apr 2002 06:32:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:57:24AM -0700, jw schultz wrote:
> 
> Rather than sort by author i, and i suspect others, would
> prefer the top-level sort be by subsystem or a recognizable
> aspect (ext2fs, VM, sched, cleanup, etc).  That way we could
> quickly scan for the patches that relate to areas of
> interest.  I am aware that currently many patches aren't
> even labled suitably but if we start doing this then
> eventually it will get better.

Some of us already state what subsystem/driver the changeset is for on
the first line of the change entry for this very reason :)

greg k-h
