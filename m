Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266625AbUBGF0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUBGF0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:26:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:18614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266625AbUBGF0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:26:12 -0500
Date: Fri, 6 Feb 2004 21:26:07 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc1
Message-ID: <20040207052607.GA2511@kroah.com>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <yw1x4qu38tyx.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x4qu38tyx.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 04:11:02AM +0100, Måns Rullgård wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > James Simmons:
> >   o [FBDEV] Add syfs support
> 
> Is this the patch some say is broken?

Yes.  Don't try to unload any fb drivers now :(

greg k-h
