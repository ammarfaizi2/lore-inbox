Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUJLU6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUJLU6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUJLU6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:58:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:54485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267783AbUJLUyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:54:47 -0400
Date: Tue, 12 Oct 2004 13:54:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Chris Wright <chrisw@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3  -- FIXED in -rc4
Message-ID: <20041012135443.E2357@build.pdx.osdl.net>
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012094439.GA3223@pclin040.win.tue.nl> <416BF927.7000000@nortelnetworks.com> <20041012130859.G2441@build.pdx.osdl.net> <416C4173.3060408@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <416C4173.3060408@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Oct 12, 2004 at 02:41:23PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortelnetworks.com) wrote:
> 2.6.9-rc4 seems sane again.  Start up two memory hogs, one gets killed immediately.

Good, thanks for checking.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
