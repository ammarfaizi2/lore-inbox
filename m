Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWIKPvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWIKPvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIKPvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:51:45 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:59843 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751313AbWIKPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:51:44 -0400
Date: Mon, 11 Sep 2006 11:49:33 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [PATCH 14/21] uml: enable scsi and add iscsi config
Message-ID: <20060911154933.GC4443@ccure.user-mode-linux.org>
References: <20060906131630.793619000@chello.nl>> <20060906133955.337828000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906133955.337828000@chello.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 03:16:44PM +0200, Peter Zijlstra wrote:
> Enable iSCSI on UML, dunno why SCSI was deemed broken, it works like a charm.

Acked-by: Jeff Dike <jdike@addtoit.com>

Although it would be nice if we didn't have to copy bits of Kconfig files
to do this.

				Jeff
