Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWINHzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWINHzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWINHzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:55:44 -0400
Received: from brick.kernel.dk ([62.242.22.158]:28948 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751438AbWINHzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:55:43 -0400
Date: Thu, 14 Sep 2006 09:53:53 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 10/11] LTTng-core 0.5.108 : relayfs
Message-ID: <20060914075353.GE7425@kernel.dk>
References: <20060914034940.GK2194@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914034940.GK2194@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13 2006, Mathieu Desnoyers wrote:
> 10 - Forward port of RelayFS 2.6.16 API, plus some enhancements.
> patch-2.6.17-lttng-core-0.5.108-relayfs.diff

One big question - why?!

-- 
Jens Axboe

