Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWEIQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWEIQXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWEIQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:23:11 -0400
Received: from ns1.mvista.com ([63.81.120.158]:34716 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751312AbWEIQXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:23:11 -0400
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
From: Daniel Walker <dwalker@mvista.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060509085157.908244000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085157.908244000@sous-sol.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:23:08 -0700
Message-Id: <1147191789.21536.33.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:

> +timers-y			:= timers/
> +timers-$(CONFIG_XEN)		:=


Is this line suppose to be empty ?

Daniel

