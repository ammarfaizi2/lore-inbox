Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbVJHANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVJHANP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVJHANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:13:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161017AbVJHANO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:13:14 -0400
Date: Fri, 7 Oct 2005 17:12:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
Subject: Re: [stable] Re: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051008001234.GL5856@shell0.pdx.osdl.net>
References: <20051007234348.631583000@press.kroah.org> <20051007235450.GE23111@kroah.com> <20051008000252.GO31529@redhat.com> <20051008000720.GC23609@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051008000720.GC23609@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> Heh, ok, care to suggest a better Subject: ?

Let's go with what's upstream:

[PATCH] Fix drm 'debug' sysfs permissions
