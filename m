Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbTC1Avc>; Thu, 27 Mar 2003 19:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTC1Avc>; Thu, 27 Mar 2003 19:51:32 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:12261 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261765AbTC1Avc>; Thu, 27 Mar 2003 19:51:32 -0500
Date: Thu, 27 Mar 2003 19:57:26 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Greg KH <greg@kroah.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: config options for PS/2 kbd and USB mouse?
In-Reply-To: <20030328004024.GE3416@kroah.com>
Message-ID: <Pine.LNX.4.44.0303271956190.1925-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Greg KH wrote:

> On Thu, Mar 27, 2003 at 06:47:29PM -0500, Robert P. J. Day wrote:
> > 
> > are there new options i should be looking at to support a
> > PS/2 keyboard on this laptop?  i've selected pretty much all
> > of the options i thought i needed, but no results so far.
> 
> Did you enable CONFIG_SERIO_I8042 ?

yup.  i can't see anything else under "Input device support"
that seems to be necessary.  still puzzled ...

rday

