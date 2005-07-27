Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVG0U6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVG0U6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVG0U4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:56:49 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:4007 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261933AbVG0UyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:54:15 -0400
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: [PATCH 18/82] remove linux/version.h from drivers/infiniband/
X-Message-Flag: Warning: May contain useful information
References: <20050710193526.18.UYMiOz2756.2247.olh@nectarine.suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 27 Jul 2005 13:53:57 -0700
In-Reply-To: <20050710193526.18.UYMiOz2756.2247.olh@nectarine.suse.de> (Olaf
 Hering's message of "Sun, 10 Jul 2005 19:35:26 +0000")
Message-ID: <52y87sug0q.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Jul 2005 20:54:08.0597 (UTC) FILETIME=[554D7050:01C592ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've finally applied this to our repository, and will merge it
upstream for 2.6.14 (unless it shows up by some other route first).

 - R.
