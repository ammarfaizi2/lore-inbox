Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284038AbRLEK7I>; Wed, 5 Dec 2001 05:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284039AbRLEK66>; Wed, 5 Dec 2001 05:58:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46075
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284038AbRLEK6q>; Wed, 5 Dec 2001 05:58:46 -0500
Date: Wed, 5 Dec 2001 02:58:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
Message-ID: <20011205105840.GA439@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <20011205050513.GD1442@cy599856-a.home.com> <3C0DB3D6.9C86B865@zip.com.au> <3C0DC1AA.E653D425@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0DC1AA.E653D425@zip.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 10:41:46PM -0800, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > 3) Something else.  HJ's #ifdef MODULE works OK.  It has a rather
> >    internecine relationship with the workings of __devexit though.
> 
> OK, here's a piece of speed-editing.  Fixed a few other __devexit
> bugs on the way as well.
> 

Thanks Andrew, you fixed it before I had the compulsion to compile a new
kernel.

I'm running 2.4.17-pre2+ext3-0.9.16+binutils now, and all is well so far.

Mike
