Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUBPVMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUBPVMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:12:36 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24518 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265848AbUBPVMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:12:34 -0500
Date: Mon, 16 Feb 2004 16:12:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.3-rc3-mm1
In-Reply-To: <Pine.LNX.3.96.1040216141554.2146A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0402161610110.11793@montezuma.fsmlabs.com>
References: <Pine.LNX.3.96.1040216141554.2146A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Bill Davidsen wrote:

> > I think it was a good change, and was appropriate to 2.5.x.  But for 2.6.x
> > the benefit didn't seem to justify the depth of the change.

Rather unfortunate that allyes didn't fix things.

> And will it be appropriate for 2.7? It really does give a start to
> trimming code you don't want in a small kernel, and would have been nice
> so people could use it for any processor specific additions to 2.6.
>
> Not arguing, but it was a step to improve control of creeping unnecessary
> archetecture support.

Well the -tiny tree has that and a lot more drastic trimmings, Andrew is
there already an arrangement to feed the not so brutal changes to you?

	Zwane
