Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWDZWf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWDZWf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWDZWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:35:59 -0400
Received: from xenotime.net ([66.160.160.81]:1491 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932422AbWDZWf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:35:58 -0400
Date: Wed, 26 Apr 2006 15:38:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060426153821.9bf0d535.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604262232460.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
	<20060419205141.63298a26.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0604262232460.32445@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 00:13:40 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Wed, 19 Apr 2006, Randy.Dunlap wrote:
> 
> > ~~~~~
> > Subject: [PATCH 12/19] kconfig: add symbol option config syntax
> > 
> > Do we have any examples of this?  (where)
> 
> It's in patch 13.
> 
> > ~~~~~
> > Subject: [PATCH 14/19] kconfig: Add search option for xconfig
> > 
> > How do I search?  I don't see it in the menu or any Help for it.
> 
> It's in the File menu or Ctrl+F, it shouldn't be that hard to find. :)

Yep, it helps to use -mm.  For some reason I thought that this was
merged in 2.6.17-rc2, but it's not.  My bad.

> > ~~~~~
> > Subject: [PATCH 15/19] kconfig: finer customization via popup menus
> > 
> > How?  documentation?
> 
> The right mouse button opens a context menu in the list header and in the 
> info text. I'm playing with ideas on how to document this best, e.g. like 
> adding a "What's this?" button. (I'm open to ideas/patches. :) )
> 
> > ~~~~~
> > Subject: [PATCH 16/19] kconfig: create links in info window
> > 
> > How?  what does link look like?  are there any in the current
> > Kconfig menus?  I'd like to see one (or several).
> > ~~~~~
> > Subject: [PATCH 17/19] kconfig: jump to linked menu prompt
> > 
> > I'd like to see this too.  Where can I see it?
> > ~~~~~
> 
> As I mentioned it's only visible if you enable "Show Debug Info", but then 
> it shouldn't be that hard to miss. Did you expect something different?

I always have Debug Info etc. enabled.  Sorry, I was using the
wrong kernel version, but your replies are still useful/helpful.
Thanks. 

---
~Randy
