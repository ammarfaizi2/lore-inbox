Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUAUXOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUAUXOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:14:12 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:1455 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266195AbUAUXNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:13:43 -0500
Date: Wed, 21 Jan 2004 17:07:08 -0500
From: Ben Collins <bcollins@debian.org>
To: Srihari Vijayaraghavan <harisri@telstra.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Solved ohci1394 oops (was: [PROBLEM] 2.6.1-mm4 ohci1394 oops)
Message-ID: <20040121220708.GK32269@phunnypharm.org>
References: <6ec69c3e.9c3e6ec6@email.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec69c3e.9c3e6ec6@email.bigpond.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:58:36AM +1100, Srihari Vijayaraghavan wrote:
> 
> Hello,
> 
> With 2.6.1-mm5 I am unable to reproduce this oops.

Thanks for the feedback. We specifically put code in there to get rid of
it :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
