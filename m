Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTIHXWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTIHXWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:22:00 -0400
Received: from holomorphy.com ([66.224.33.161]:4007 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263752AbTIHXWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:22:00 -0400
Date: Mon, 8 Sep 2003 16:22:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-ID: <20030908232237.GL4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org
References: <3F5D023A.5090405@austin.ibm.com> <20030908155639.2cdc8b56.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908155639.2cdc8b56.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 03:56:39PM -0700, Andrew Morton wrote:
> hmm, thanks.
> I'm not sure that volanomark is very representative of any real-world
> thing.

AIUI it's dominated by 3-tier locking issues.


-- wli
