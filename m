Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265449AbSJSBcz>; Fri, 18 Oct 2002 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265450AbSJSBcy>; Fri, 18 Oct 2002 21:32:54 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:18131
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265449AbSJSBcy>; Fri, 18 Oct 2002 21:32:54 -0400
Date: Fri, 18 Oct 2002 21:38:49 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Greg KH <greg@kroah.com>
cc: pavel@bug.ucw.cz, <linux-kernel@vger.kernel.org>
Subject: Re: Zaurus support for usbnet.c
In-Reply-To: <20021018210224.GB9777@kroah.com>
Message-ID: <Pine.LNX.4.44.0210182137130.5873-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Greg KH wrote:

> Doesn't the usbdnet.c driver support the Zaurus?

Both the Zaurus and the iPAQ are using a SA1110 which is already supported 
by usbnet.


Nicolas

