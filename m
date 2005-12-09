Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVLIJQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVLIJQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 04:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLIJQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 04:16:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:6576 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751179AbVLIJQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 04:16:41 -0500
Date: Fri, 9 Dec 2005 10:16:40 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Rafael Wysocki <rjw@sisk.pl>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Message-ID: <20051209091640.GF11190@wotan.suse.de>
References: <20051204232153.258cd554.akpm@osdl.org> <43980058.76F0.0078.0@novell.com> <200512081153.51397.rjw@sisk.pl> <200512082335.50417.rjw@sisk.pl> <43995957.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43995957.76F0.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 10:15:51AM +0100, Jan Beulich wrote:
> It's a possible way to address this, but I'd rather just set a flag
> indicating that the last-whatever values should not be considered (to
> get into a state just like after initial boot). Jan

Sounds reasonable.
-Andi
