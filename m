Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVFWPNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVFWPNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVFWPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:13:37 -0400
Received: from 1-1-2-5a.f.sth.bostream.se ([81.26.255.57]:53184 "EHLO
	1-1-2-5a.f.sth.bostream.se") by vger.kernel.org with ESMTP
	id S262481AbVFWPN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:13:26 -0400
Date: Thu, 23 Jun 2005 17:13:18 +0200 (CEST)
From: Per Liden <per@fukt.bth.se>
X-X-Sender: per@1-1-2-5a.f.sth.bostream.se
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
In-Reply-To: <20050623064847.GC11638@kroah.com>
Message-ID: <Pine.LNX.4.63.0506231709090.3147@1-1-2-5a.f.sth.bostream.se>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org>
 <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org>
 <20050623045959.GB10386@kroah.com> <20050623062842.GE17453@mikebell.org>
 <20050623064847.GC11638@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Greg KH wrote:

> On Wed, Jun 22, 2005 at 11:28:42PM -0700, Mike Bell wrote:
> > On Wed, Jun 22, 2005 at 09:59:59PM -0700, Greg KH wrote:
[...]
> > > 	- no distro uses it
> > 
> > Bull. Complete. Can I claim by similar logic that no distro uses udev?
> 
> What distro shipps support for devfs and a 2.6 kernel?  I am not aware
> of one (Gentoo doesn't count, they don't "ship" anything :)  Honestly, I
> don't know of any.  I do know of a lot of them that ship udev.

CRUX (http://crux.nu) is one example of such a dist.

/Per
