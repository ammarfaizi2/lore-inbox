Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTJGUxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJGUxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:53:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:4784 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262781AbTJGUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:53:03 -0400
Date: Tue, 7 Oct 2003 13:52:44 -0700
From: Greg KH <greg@kroah.com>
To: insecure <insecure@mail.od.ua>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Subject: Re: devfs and udev
Message-ID: <20031007205244.GA2978@kroah.com>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310072347.41749.insecure@mail.od.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 11:47:41PM +0300, insecure wrote:
> On Tuesday 07 October 2003 22:41, Greg KH wrote:
> > On Tue, Oct 07, 2003 at 09:28:09PM +0300, insecure wrote:
> > > What am I supposed to do, starting to use mknod again? Uggggh...
> >
> > Provide me with a kernel name to devfs name mapping file so that I can
> > create a "devfs like" udev config file for people who happen to like
> > that naming scheme.
> 
> It seems that we have a bit of misunderstanding here.
> 
> I just don't want to go back to /dev being actually placed on
> real, on-disk fs.
> 
> I won't mind if naming scheme will change as long
> as device names start with '/dev/' and appear
> there (semi-)automagically. That's what I call devfs.
> If udev can do this, I am all for that.

udev can do this.  Is there some documentation that you read that has
suggested otherwise?

greg k-h
