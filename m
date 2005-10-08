Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVJHAJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVJHAJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbVJHAJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:09:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161016AbVJHAJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:09:19 -0400
Date: Fri, 7 Oct 2005 17:08:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
Subject: Re: [stable] Re: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051008000822.GK5856@shell0.pdx.osdl.net>
References: <20051007234348.631583000@press.kroah.org> <20051007235450.GE23111@kroah.com> <20051008000252.GO31529@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051008000252.GO31529@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> For those scratching their heads, the subject line came
> about as a result of my following up an older issue.
> This has nothing to do with signedness of course :-)

Yes, you're right.  That's my fault for not editing the patch better
before adding it to the queue.

thanks,
-chris
