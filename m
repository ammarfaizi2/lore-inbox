Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSAUR0y>; Mon, 21 Jan 2002 12:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSAUR0o>; Mon, 21 Jan 2002 12:26:44 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:37037 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S287565AbSAUR0X>; Mon, 21 Jan 2002 12:26:23 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: jepler@unpythonic.dhs.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020121105817.B1520@unpythonic.dhs.org>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com> <3C4C1C96.9330C916@redhat.com>
	 <20020121105817.B1520@unpythonic.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 12:26:06 -0500
Message-Id: <1011633971.384.12.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 11:58, jepler@unpythonic.dhs.org wrote:
> On Mon, Jan 21, 2002 at 01:50:14PM +0000, Arjan van de Ven wrote:
> > "David S. Miller" wrote:
> > 
> > > The funny part is, if this published errata is the problem, it cannot
> > > be a problem under Linux since we never invalidate 4MB pages.  We
> > > create them at boot time and they never change after that.
> > 
> > Well we don't know what nvidia's kernel module is doing.....
> 
> .. which makes it not a kernel bug, right?  Just some buggy module that
> bangs hardware in a way documented to not work...
> 

Would seem so since it's been one and a half years and nobody has
encountered this bug in linux.  

Damn you gotta love slashdot. It's like the Internet's smut mag.  If
their news is going to be so old it should be because they're actually
looking into the story they're posting with some kind of review
process.  

