Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWDNNDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWDNNDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWDNNDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 09:03:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13021 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751243AbWDNNDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 09:03:08 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 14 Apr 2006 15:02:40 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/4] sbp2: improved handling of device quirks
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, Jody McIntyre <scjody@modernduck.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
Message-ID: <tkrat.39d15159078effeb@s5r6.in-berlin.de>
References: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.284) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> [PATCH 3/4] sbp2: make TSB42AA9 workaround specific to Momobay CX-1
...
> Requires PATCH 1/4.

Also requires patch 2/4 for a new struct member.
-- 
Stefan Richter
-=====-=-==- -=-- -===-
http://arcgraph.de/sr/

