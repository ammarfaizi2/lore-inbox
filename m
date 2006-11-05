Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWKEE7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWKEE7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWKEE7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:59:53 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37299 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030205AbWKEE7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:59:52 -0500
Message-ID: <454D6FC7.3040308@vmware.com>
Date: Sat, 04 Nov 2006 20:59:51 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs	for	paravirtualizing
 critical operations
References: <20061029024504.760769000@sous-sol.org>	 <200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>	 <200611032209.40235.ak@suse.de> <1162701815.29777.6.camel@localhost.localdomain>
In-Reply-To: <1162701815.29777.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Andi, the patches work against Andrew's tree, and he's merged them in
> rc4-mm2.  There are a few warnings to clean up, but it seems basically
> sound.
>
> At this point I our think time is better spent on beating those patches
> up, rather than going back and figuring out why they don't work in your
> tree.
>   

This begs the question - should we rebase the paravirt-ops patchset 
against -rc4-mm2?  I almost did it today, but didn't want to stomp on 
anybody else's toes.

Zach
