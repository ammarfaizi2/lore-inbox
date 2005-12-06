Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVLFSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVLFSCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVLFSCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:02:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:45036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964986AbVLFSB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:28 -0500
Date: Tue, 6 Dec 2005 09:55:52 -0800
From: Greg KH <greg@kroah.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: "M." <vo.sinh@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206175551.GH3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com> <20051203211209.GA4937@kroah.com> <87y82z10pq.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y82z10pq.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:19:29AM +0100, Florian Weimer wrote:
> * Greg KH:
> 
> >> Yes but not home users with relatively new/bleeding edge hardware or
> >> small projects writing for example a wifi driver or a security patch
> >> or whatever without full time commitment to tracking kernel changes.
> >
> > If you are a user that wants this kind of support, then use a distro
> > that can handle this.  Obvious examples that come to mind are both
> > Debian and Gentoo and Fedora and OpenSuSE, and I'm sure there are
> > others.
> 
> IIRC, Gentoo ignores some kinds of security bugs so that the task
> remains manageable.

Do you have specific details about this?  I know the Gentoo kernel team
is currently revamping the way they handle their security updates, as it
is known to need some work.  I'm sure they would be glad for input into
this process.

thanks,

greg k-h
