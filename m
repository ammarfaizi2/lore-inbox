Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbULJE7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbULJE7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULJE7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:59:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:12519 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbULJE7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:59:17 -0500
Date: Thu, 9 Dec 2004 20:59:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Robert Love <rml@novell.com>
Cc: Timothy Chavez <chavezt@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, ttb@tentacle.dhs.org
Subject: Re: [audit] Upstream solution for auditing file system objects
Message-ID: <20041209205914.A2357@build.pdx.osdl.net>
References: <f2833c760412091602354b4c95@mail.gmail.com> <20041209174610.K469@build.pdx.osdl.net> <f2833c76041209185024cb1c4d@mail.gmail.com> <1102650138.6052.228.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1102650138.6052.228.camel@localhost>; from rml@novell.com on Thu, Dec 09, 2004 at 10:42:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Love (rml@novell.com) wrote:
> What we both need, ultimately, is a generic file change notification
> system.  This way inotify, dnotify, your audit thing, and whatever else
> can hook into the filesystem as desired.

Yup, makes sense.  From my handwavy perspective inotify was the generic
file event notifcation mechanism, but I agree with your point.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
