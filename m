Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUBXUZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUBXUZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:25:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:35028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262440AbUBXUZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:25:39 -0500
Date: Tue, 24 Feb 2004 12:25:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: Martin Dorey <mdorey@bluearc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: init_dev accesses out-of-bounds tty index
Message-ID: <20040224122534.K22989@build.pdx.osdl.net>
References: <AD4480A509455343AEFACCC231BA850FF0FE5A@ukexchange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <AD4480A509455343AEFACCC231BA850FF0FE5A@ukexchange>; from mdorey@bluearc.com on Tue, Feb 24, 2004 at 06:15:11PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Dorey (mdorey@bluearc.com) wrote:
> (nvidia) tainted kernel warning so you may wish to stop reading here.

can you recreate this w/out nvidia?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
