Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTG0GmD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270685AbTG0GmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:42:03 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38365 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270684AbTG0GmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:42:01 -0400
Date: Sun, 27 Jul 2003 08:57:10 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-ID: <20030727065710.GC17724@louise.pinerecords.com>
References: <20030726200213.GD16160@louise.pinerecords.com> <20030726194651.5e3f00bb.rddunlap@osdl.org> <20030727025647.GB17724@louise.pinerecords.com> <20030726204623.47b08882.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726204623.47b08882.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | > 3.  The help text for Software Suspend (not part of this patch)
> | > really needs some help.  Would you address that or shall I?
> | 
> | Sure, it would be nice if you could fish out an entry from somewhere.
> 
> OK, how's this look?

Looks good to me.  IMHO it would be appropriate to put the two (identical)
swsusp entries in a single Kconfig file and reference that from the arch
Kconfigs, though (while you're at it :D).

-- 
Tomas Szepe <szepe@pinerecords.com>
