Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWCJNks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCJNks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWCJNks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:40:48 -0500
Received: from mx.pathscale.com ([64.160.42.68]:61126 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751086AbWCJNkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:40:47 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310054805.GA29961@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
	 <1141951725.10693.88.camel@serpentine.pathscale.com>
	 <20060310010403.GC9945@suse.de>
	 <1141965696.14517.4.camel@camp4.serpentine.com>
	 <20060310054805.GA29961@suse.de>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 05:40:56 -0800
Message-Id: <1141998057.28926.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 21:48 -0800, Greg KH wrote:

> Oh, and you can test this out if you don't have a pci hotplug system by
> using the fakephp driver and disconnecting your device that way.

That's good to know, thanks.

	<b

