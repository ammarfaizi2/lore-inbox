Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSFKGHp>; Tue, 11 Jun 2002 02:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFKGHo>; Tue, 11 Jun 2002 02:07:44 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:4105 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316838AbSFKGHo>;
	Tue, 11 Jun 2002 02:07:44 -0400
Date: Mon, 10 Jun 2002 23:03:54 -0700
From: Greg KH <greg@kroah.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: David Ford <david+cert@blue-labs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2, compile warnings/failures
Message-ID: <20020611060353.GA6711@kroah.com>
In-Reply-To: <3D0518BF.4090404@blue-labs.org> <Pine.LNX.4.44.0206101855290.17269-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 14 May 2002 05:00:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 06:59:36PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 10 Jun 2002, David Ford wrote:
> > People, please don't do things like:
> > 
> > [bad use of doublequotes]
> > 
> > Patches keep going in to fix this.
> > 
> > [good use of doublequotes]
> 
> The same applies to 2.5. Can someone write a perl script that treats it so 
> anonymous that it can find these buggy places?

And could someone actually _tell_ the maintainers of these drivers that
there is a problem?  And what compiler version causes it?

This the first I've heard of this problem.

greg k-h
