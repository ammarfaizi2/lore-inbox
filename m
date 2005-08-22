Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVHVXKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVHVXKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHVXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:10:19 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:56464 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932359AbVHVXKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:10:16 -0400
Subject: Re: New maintainer needed for the Linux smb filesystem
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <p73wtmf11f5.fsf@verdi.suse.de>
References: <20050821143457.GA5726@stusta.de.suse.lists.linux.kernel>
	 <p73wtmf11f5.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 21 Aug 2005 20:48:36 -0400
Message-Id: <1124671716.5208.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 22:26 +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > Since Urban Widmark was not active for some time, and I didn't have any 
> > success trying to reach him, it seems we need a new maintainer for the 
> > smb filesystem in the Linux kernel.
> > 
> > Is there anyone who both feels qualified and wants to become the new 
> > maintainer?
> 
> One way would be to just deprecate and later drop it and let people
> use cifs instead which is maintained. It only doesn't work with
> some extremly old smb servers which are probably not very numerous
> anymore.

Or you could deprecate it and later drop it and when people complain,
you just found your new maintainer :-)

-- Steve


