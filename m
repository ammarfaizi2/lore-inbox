Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVLaQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVLaQkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVLaQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:40:52 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13233 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965018AbVLaQkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:40:51 -0500
Date: Sat, 31 Dec 2005 17:40:16 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       jmerkey@wolfmountaingroup.com
Subject: Re: userspace breakage
Message-ID: <20051231164016.GA8162@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B453CA.9090005@wolfmountaingroup.com> <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org> <43B46078.1080805@wolfmountaingroup.com> <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org> <1135974176.6039.71.camel@localhost.localdomain> <20051230154954.47be93a3.akpm@osdl.org> <1136018010.2901.2.camel@laptopd505.fenrus.org> <1136043030.6039.97.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136043030.6039.97.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> :
[...]
> Yeah, but maybe Andrew isn't even talking about those boards.  I know
> when I worked for Lockheed, they had a bunch of custom boards that were
> for one specific project.  There would really be no point in pushing a
> driver into the mainline that is used by one board for one project.

If the board is not based on a custom asic, there is a point.

-- 
Ueimor
