Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319300AbSIKTYg>; Wed, 11 Sep 2002 15:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319301AbSIKTYg>; Wed, 11 Sep 2002 15:24:36 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:1687
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S319300AbSIKTYf>; Wed, 11 Sep 2002 15:24:35 -0400
Date: Wed, 11 Sep 2002 15:29:12 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
cc: Otto Wyss <otto.wyss@bluewin.ch>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Portrait display mode with framebuffer drivers
In-Reply-To: <20020911171251.GD1383@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.44.0209111527350.23859-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Erik Mouw wrote:

> On Mon, Sep 09, 2002 at 09:43:49PM +0200, Otto Wyss wrote:
> > I'm considering buying a SyncMaster 171T which is turn able 90? and comes with
> > the Pivot software for Macintosh and Windows. Are the framebuffer drivers also
> > capable of turning the display 90?? If yes is it possible for any graphics card
> > or are there any limitations?
> 
> XFree can do it on Compaq Ipaq handhelds running Linux (which use dumb
> framebuffers). No kernel support needed, runs out-of-the-box.

However, the kernel support for rotating the virtual console text is still
missing.


Nicolas

