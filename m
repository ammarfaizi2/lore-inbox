Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVEXW0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVEXW0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEXWYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:24:41 -0400
Received: from webmail.topspin.com ([12.162.17.3]:3261 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262125AbVEXWXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:23:10 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 0/2] IB: allow NULL sa_query callbacks
X-Message-Flag: Warning: May contain useful information
References: <20055241520.Hsf2RosQGYxIWuXH@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 24 May 2005 15:23:03 -0700
In-Reply-To: <20055241520.Hsf2RosQGYxIWuXH@topspin.com> (Roland Dreier's
 message of "Tue, 24 May 2005 15:20:57 -0700")
Message-ID: <52vf58tgag.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 May 2005 22:23:03.0838 (UTC) FILETIME=[26EA9BE0:01C560AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

err, sorry -- slight screwup in the subject lines due to a bug in my
patch scripts.  These should obviously be 1-based rather than 0-based.
Anyway, the patches themselves should be fine.

Thanks,
  Roland

