Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWEIXWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWEIXWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWEIXWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:22:31 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44930 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932085AbWEIXWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:22:31 -0400
Date: Tue, 9 May 2006 16:25:30 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable unsupported config options.
Message-ID: <20060509232530.GF24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085145.790527000@sous-sol.org> <1147186032.21536.16.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060509151651.GI7834@cl.cam.ac.uk> <1147190433.21536.28.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147190433.21536.28.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Walker (dwalker@mvista.com) wrote:
> I guess that true .. Might be better just to support SMP then ..

Yes, and of course Xen does.  This is just the smallest functional set of
patches to get discussion, so the SMP bits were dropped for now.

thanks,
-chris
