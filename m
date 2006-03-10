Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWCJRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWCJRFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCJRFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:05:40 -0500
Received: from mx.pathscale.com ([64.160.42.68]:5592 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751925AbWCJRFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:05:39 -0500
Subject: Re: [openib-general] Re: [PATCH 8 of 20] ipath - sysfs support for
	core driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Hal Rosenstock <halr@voltaire.com>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, davem@davemloft.net
In-Reply-To: <20060310165452.GA11382@suse.de>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
	 <20060310011106.GD9945@suse.de>
	 <1141967377.14517.32.camel@camp4.serpentine.com>
	 <20060310063724.GB30968@suse.de> <adairqmbb24.fsf@cisco.com>
	 <1142003287.4331.28584.camel@hal.voltaire.com>
	 <20060310165452.GA11382@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 09:05:38 -0800
Message-Id: <1142010338.29925.32.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 08:54 -0800, Greg KH wrote:

> Great, that means they should NOT be exported to userspace in this
> fashion...

OK, into debugfs or ipathfs or some other such place they'll go, then.

	<b

