Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUKNJxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUKNJxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKNJxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:53:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:35970 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261273AbUKNJxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:53:48 -0500
Date: Sun, 14 Nov 2004 10:50:51 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, mingo@elte.hu, seto.hidetoshi@jp.fujitsu.com
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-ID: <20041114095051.GA11391@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
	seto.hidetoshi@jp.fujitsu.com
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114092308.GA4389@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 09:23:08AM +0000, Jamie Lokier wrote:

> So I don't know if NPTL is buggy, but the pseudo-code given in the bug
> report is (because of unconditional wake++), and so is the failure
> example (because it doesn't use a mutex).

Please advise if 'Emergency Services''s update to the manpage is correct
(two levels up this message thread), if so, I can apply it and forward to
aeb.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
