Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUGZTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUGZTie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUGZTfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:35:31 -0400
Received: from mail1.kontent.de ([81.88.34.36]:749 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265305AbUGZSNh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:13:37 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [patch] kernel events layer
Date: Mon, 26 Jul 2004 20:13:33 +0200
User-Agent: KMail/1.6.2
Cc: Robert Love <rml@ximian.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407> <1090853403.1973.11.camel@localhost> <20040726161221.GC17449@kroah.com>
In-Reply-To: <20040726161221.GC17449@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407262013.33454.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. Juli 2004 18:12 schrieb Greg KH:
> > If Greg can come up with a solution for using kobjects, I am all for
> > that - that would be great - but I really do not see kobject paths
> > working out.  I think the best we have is the file path in the tree.
> 
> Give me a few days, I'm working on it, but have been traveling too much.
> Robert and I will sit down during OSCON this week and try to work out
> something along these lines, and then post it again here.

On a related note, is this supposed to supersede the current hotplug
mechanism?

	Regards
		Oliver
