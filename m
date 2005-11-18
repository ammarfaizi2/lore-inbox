Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVKRXfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVKRXfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVKRXfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:35:20 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:31995 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751179AbVKRXfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:35:19 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: 2.6.15-rc1-mm1
Date: Fri, 18 Nov 2005 18:35:11 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20051117111807.6d4b0535.akpm@osdl.org> <cbec11ac0511181314g7edaee33j47cbc6118228e49b@mail.gmail.com> <200511181816.01645.tomlins@cam.org>
In-Reply-To: <200511181816.01645.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181835.11719.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 18:16, Ed Tomlinson wrote:
> On Friday 18 November 2005 16:14, Ian McDonald wrote:
> > On 11/19/05, Greg KH <greg@kroah.com> wrote:
> > > Are you using debian?
> > > If so, what version of udev are you using?  There are some known
> > > reported problems with this, so I would suggest referring to the udev
> > > bug list.
> > >
> > In particular check the version requirements for udev - you need to be
> > on a version greater than or equal to 71. Sarge/stable has a really
> > old version. In particular I am running unstable as I had too many
> > funny errors (including this one) - but etch should be fine.
> > 
> > If running another distribution check this also as it is a real requirement.
> > 
> > To find the latest version of udev required check Documentation/Changes
> 
> devinfo -v 
> udevinfo, version 074 
> 
> dpkg -s 
> Package: udev
> Status: install ok installed
> Priority: extra
> Section: admin
> Installed-Size: 1072
> Maintainer: Marco d'Itri <md@linux.it>
> Architecture: amd64
> Version: 0.074-3
> 
> Interestingly the same udev works fine with 14-rc4-mm1.  I'll check the debian
> bugs.

There does not seem to be anything that fits this reported as a debian bug.  Where
is the udev bugs list?

TIA
Ed Tomlinson 
