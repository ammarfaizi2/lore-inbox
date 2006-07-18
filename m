Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWGRWzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWGRWzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGRWzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:55:49 -0400
Received: from gw.goop.org ([64.81.55.164]:51639 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932339AbWGRWzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:55:48 -0400
Message-ID: <44BD416B.2090103@goop.org>
Date: Tue, 18 Jul 2006 13:15:39 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 05/33] Makefile support to build Xen subarch
References: <20060718091807.467468000@sous-sol.org>	 <20060718091949.842251000@sous-sol.org> <1153216813.3038.22.camel@laptopd505.fenrus.org>
In-Reply-To: <1153216813.3038.22.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> please change the order of your patches next time, by sending the
> makefile and config options first you'll break git bisect...
>   
I think Chris was planning on doing this, but I suspect it got put to 
one side in order to get the patch set out in time for KS.

    J

