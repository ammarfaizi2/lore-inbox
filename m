Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTLDXVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTLDXVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:21:51 -0500
Received: from holomorphy.com ([199.26.172.102]:62161 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263723AbTLDXVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:21:50 -0500
Date: Thu, 4 Dec 2003 15:21:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031204232145.GB8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com> <20031204225828.GZ3734@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204225828.GZ3734@actcom.co.il>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
>> Successfully tested on a Thinkpad T21. Any feedback regarding
>> performance would be very helpful. Desktop users should notice top(1)
>> is faster, kernel hackers that kernel compiles are faster, and highmem
>> users should see much less per-process lowmem overhead.

On Fri, Dec 05, 2003 at 12:58:29AM +0200, Muli Ben-Yehuda wrote:
> Compiles and boots fine with a minimal .config on my thinkpad R30
> sacrificial machine. 

Good to hear; I hope the various performance improvements (as they're
intended to be, at least) do something for the R30.


-- wli
