Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTK1VvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTK1VvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:51:01 -0500
Received: from holomorphy.com ([199.26.172.102]:5316 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263527AbTK1VvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:51:00 -0500
Date: Fri, 28 Nov 2003 13:50:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031128215031.GC8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128215008.GA2541@nasledov.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 01:50:08PM -0800, Misha Nasledov wrote:
> It would be really annoying if my laptop suspended when I closed the lid; I
> disabled this feature in the BIOS. I will test if it suspends with
> this feature enabled, but it doesn't change the fact that there is
> something broken with APM. Running 'apm --suspend' doesn't work either.

That sounds h0rked; we might need to drag in suspend experts for this...


-- wli
