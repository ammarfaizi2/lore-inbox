Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVAUW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVAUW71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVAUW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:59:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262560AbVAUW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:59:22 -0500
Subject: Re: [ea-in-inode 0/5] Further fixes
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050120020124.110155000@suse.de>
References: <20050120020124.110155000@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106348336.1989.484.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 21 Jan 2005 22:58:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, 2005-01-20 at 02:01, Andreas Gruenbacher wrote:

> here is a set of fixes for ext3 in-inode attributes:

Obvious first question --- have these diffs survived the same
torture-by-tridgell that the previous batch suffered?

Cheers,
 Stephen

