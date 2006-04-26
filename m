Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWDZWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWDZWNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWDZWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:13:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31189 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964899AbWDZWNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:13:48 -0400
Date: Thu, 27 Apr 2006 00:13:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
In-Reply-To: <20060419205141.63298a26.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0604262232460.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
 <20060419205141.63298a26.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Apr 2006, Randy.Dunlap wrote:

> ~~~~~
> Subject: [PATCH 12/19] kconfig: add symbol option config syntax
> 
> Do we have any examples of this?  (where)

It's in patch 13.

> ~~~~~
> Subject: [PATCH 14/19] kconfig: Add search option for xconfig
> 
> How do I search?  I don't see it in the menu or any Help for it.

It's in the File menu or Ctrl+F, it shouldn't be that hard to find. :)

> ~~~~~
> Subject: [PATCH 15/19] kconfig: finer customization via popup menus
> 
> How?  documentation?

The right mouse button opens a context menu in the list header and in the 
info text. I'm playing with ideas on how to document this best, e.g. like 
adding a "What's this?" button. (I'm open to ideas/patches. :) )

> ~~~~~
> Subject: [PATCH 16/19] kconfig: create links in info window
> 
> How?  what does link look like?  are there any in the current
> Kconfig menus?  I'd like to see one (or several).
> ~~~~~
> Subject: [PATCH 17/19] kconfig: jump to linked menu prompt
> 
> I'd like to see this too.  Where can I see it?
> ~~~~~

As I mentioned it's only visible if you enable "Show Debug Info", but then 
it shouldn't be that hard to miss. Did you expect something different?

bye, Roman
