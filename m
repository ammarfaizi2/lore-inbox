Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269594AbUHZVjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269594AbUHZVjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269707AbUHZVdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:33:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:50615 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269690AbUHZV3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:29:20 -0400
Date: Thu, 26 Aug 2004 14:29:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Rik van Riel <riel@redhat.com>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826142907.B1973@build.pdx.osdl.net>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org> <45010000.1093553046@flay> <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Aug 26, 2004 at 01:54:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> The _big_ difference is that when you can make the compound object _look_ 
> like a directory, that means that you can now manage the attributes with 
> standard tools. They are still attributes, though.

For things that actually use such attributes to determine file access, do the
attributes get attributes?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
