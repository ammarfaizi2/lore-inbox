Return-Path: <linux-kernel-owner+w=401wt.eu-S1161329AbXAHQEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbXAHQEm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbXAHQEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:04:42 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:4204 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161329AbXAHQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:04:41 -0500
Date: Mon, 8 Jan 2007 10:32:36 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>
Subject: Re: [patch 09/50] Revert "[PATCH] zd1211rw: Removed unneeded packed attributes"
Message-ID: <20070108153220.GE22498@tuxdriver.com>
References: <20070106022753.334962000@sous-sol.org> <20070106023028.655317000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106023028.655317000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 06:28:02PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: John W. Linville <linville@tuxdriver.com>
> 
> This reverts commit 4e1bbd846d00a245dcf78b6b331d8a9afed8e6d7.
> 
> Quoth Daniel Drake <dsd@gentoo.org>:
> 
> "A user reported that commit 4e1bbd846d00a245dcf78b6b331d8a9afed8e6d7
> (Remove unneeded packed attributes) breaks the zd1211rw driver on ARM."
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>

ACK

-- 
John W. Linville
linville@tuxdriver.com
