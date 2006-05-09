Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEIQ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEIQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEIQ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:29:34 -0400
Received: from ns1.mvista.com ([63.81.120.158]:38052 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750747AbWEIQ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:29:34 -0400
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
From: Daniel Walker <dwalker@mvista.com>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060509161850.GK7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085147.903310000@sous-sol.org>
	 <1147190772.21536.30.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060509161850.GK7834@cl.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:29:31 -0700
Message-Id: <1147192172.21536.35.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 17:18 +0100, Christian Limpach wrote:

> 
> The full set of interface headers supports several architectures.
> 
> I think having all the header files in one place is preferable,
> but will gladly move them wherever is agreed on to be best ;-)

I'd say include/linux/xen/ would be a better choice, if it's multi
architecture ..

Daniel

