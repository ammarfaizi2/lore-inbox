Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUHBTG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUHBTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHBTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:06:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262106AbUHBTG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:06:56 -0400
Date: Mon, 2 Aug 2004 15:06:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20040802101905.GJ6295@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408021506200.25305-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Andrea Arcangeli wrote:
> On Mon, Aug 02, 2004 at 02:05:20AM +0200, Andi Kleen wrote:
> > I don't think a sequence number is a good idea. Consider a
> > vendor/third party kernel fixing a security bug, but mainline hasn't
> > taken the patch yet for some reason.
> 
> does this really happen?

Think EVMS in a certain SuSE kernel.  Hard to imagine
no security bugs got fixed in that code ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

