Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVDCUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVDCUlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVDCUlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:41:06 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:37831 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261409AbVDCUlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:41:01 -0400
Date: Sun, 3 Apr 2005 13:40:45 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] configfs, a filesystem for userspace-driven kernel object configuration
Message-ID: <20050403204045.GI31163@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20050403195728.GH31163@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403195728.GH31163@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.8i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:57:28PM -0700, Joel Becker wrote:
> 	I humbly submit configfs.  With configfs, a configfs
> ...
> 	Patch is against 2.6.12-rc1-bk3.

	Updated for bk5 and the new backing_dev capabilites mask:

http://oss.oracle.com/~jlbec/files/configfs/2.6.12-rc1-bk5/configfs-2.6.12-rc1-bk5-1.patch

Joel

-- 

"Against stupidity the Gods themselves contend in vain."
	- Freidrich von Schiller

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
