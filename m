Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVELHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVELHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVELHr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 03:47:57 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:13842 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261228AbVELHrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:47:52 -0400
Date: Thu, 12 May 2005 09:47:32 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050512094732.I7594@banaan.localdomain>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain> <1115770106.17201.21.camel@localhost.localdomain> <20050511031103.C7594@banaan.localdomain> <1115782753.17201.54.camel@localhost.localdomain> <20050511115955.D7594@banaan.localdomain> <1115808722.16408.3.camel@localhost.localdomain> <20050511105818.GB8761@wonderland.linux.it> <20050511150604.E7594@banaan.localdomain> <1115872771.6739.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1115872771.6739.27.camel@localhost.localdomain>; from rusty@rustcorp.com.au on Thu, May 12, 2005 at 02:39:31PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 02:39:31PM +1000, Rusty Russell wrote:
> Applied, with testsuite and documentation, released as pre5.  Diff below
> for your convenience.  Erik, if you could use "./tests/runtests -vv
> 02proc.sh" and tell me what's failing for you, that'd help (an unwitting
> distro dependency?)

False alarm.  The test suites for pre4 and pre5 now both pass here,
so the earlier errors were probably due to some sloppyness on my side.

Regards,
Erik
