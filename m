Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUJOOxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUJOOxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJOOxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:53:53 -0400
Received: from holomorphy.com ([207.189.100.168]:52618 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267973AbUJOOw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:52:27 -0400
Date: Fri, 15 Oct 2004 07:52:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015145217.GJ5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015142825.GI5607@holomorphy.com> <1097851258.2666.13421.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097851258.2666.13421.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 10:28, William Lee Irwin III wrote:
>> The overhead is too catastrophic to tolerate. Please work with us
>> to find a sufficient approximation to whatever statistics you want
>> opposed to reverting to 2.4 algorithms or ones of similar expense.

On Fri, Oct 15, 2004 at 10:40:58AM -0400, Albert Cahalan wrote:
> Why not get rid of rss too then? It's overhead.

If you can't distinguish catastrophic from non-catastrophic you are
beyond my ability to help you.


-- wli
