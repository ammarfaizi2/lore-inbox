Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTLJAAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLJAAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:00:55 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:36480
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263531AbTLJAAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:00:53 -0500
Date: Tue, 9 Dec 2003 18:59:49 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
In-Reply-To: <20031209233523.GS8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312091859330.2313@montezuma.fsmlabs.com>
References: <20031204200120.GL19856@holomorphy.com> <20031209233523.GS8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, William Lee Irwin III wrote:

> On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
> > Successfully tested on a Thinkpad T21. Any feedback regarding
> > performance would be very helpful. Desktop users should notice top(1)
> > is faster, kernel hackers that kernel compiles are faster, and highmem
> > users should see much less per-process lowmem overhead.
>
> Bill Davidsen reported an issue where compiled kernel images aren't
> properly distinguished from mainline kernels' by installation scripts.
>
> The following patch should resolve this:

Argh, i've been screaming about this for ages...
