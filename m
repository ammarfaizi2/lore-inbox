Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWIYFiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWIYFiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWIYFiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:38:23 -0400
Received: from gw.goop.org ([64.81.55.164]:21123 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751771AbWIYFiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:38:22 -0400
Message-ID: <45176B53.7040608@goop.org>
Date: Sun, 24 Sep 2006 22:38:27 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
References: <20060924013521.13d574b1.akpm@osdl.org>	<4517256E.10606@goop.org> <20060924223427.6f42e77c.akpm@osdl.org>
In-Reply-To: <20060924223427.6f42e77c.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It may be related to the .config, rather than the CPU type.
>   

Hm, wonder if it's !4K stacks...

J
