Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTLHEyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbTLHEyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:54:55 -0500
Received: from holomorphy.com ([199.26.172.102]:16602 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265335AbTLHEyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:54:53 -0500
Date: Sun, 7 Dec 2003 20:53:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Symonds <mark@symonds.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Harald Welte <laforge@netfilter.org>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031208045336.GD8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mark Symonds <mark@symonds.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@redhat.com>,
	Harald Welte <laforge@netfilter.org>
References: <Pine.LNX.4.44.0312071236430.1283-100000@logos.cnet> <008501c3bd18$697361e0$7a01a8c0@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008501c3bd18$697361e0$7a01a8c0@gandalf>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 03:18:24PM -0800, Mark Symonds wrote:
> I'm using ipchains compatability in there, looks like 
> this is a possible cause - getting a patch right now,
> will test and let y'all know (and then switch to 
> iptables, finally). 

For the purposes of fixing the bogon, it might be helpful to stick to
whatever triggered the problem just long enough to extract more
information.


-- wli
