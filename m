Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUCIPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUCIPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:01:56 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:47369 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261976AbUCIPBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:01:53 -0500
Date: Tue, 9 Mar 2004 10:01:50 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <20040308233431.10a6b4c4.davem@redhat.com>
Message-ID: <Pine.OSF.4.21.0403090949380.79394-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Mar 2004, David S. Miller wrote:

> Date: Mon, 8 Mar 2004 23:34:31 -0800
> From: David S. Miller <davem@redhat.com>
> To: Ron Peterson <rpeterso@MtHolyoke.edu>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: network / performance problems
> 
> On Sat, 6 Mar 2004 09:55:09 -0500 (EST)
> Ron Peterson <rpeterso@MtHolyoke.edu> wrote:
> 
> > My understanding is that the kernel profile information will become
> > interesting when the machine starts thrashing.
> 
> Yes, now please, pretty please, get us the profiles...

http://depot.mtholyoke.edu:8080/tmp/tap-sam/2004-03-09_09:30/

The machines is not really thrashing yet, but I'd expect in another couple
days, if experience holds, that it will be gonzo.  I'd like to revert back
to 2.4.20 before then, as this is a production machine.  I'll leave it
going as is for a short while, however, in case anyone has any suggestions
about things I should look at while it's misbehaving.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College


