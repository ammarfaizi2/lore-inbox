Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUDEWrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDEWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:47:05 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:19335 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262984AbUDEWpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:45:40 -0400
Subject: Re: [PATCH] Drop exported symbols list if !modules
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20040405205539.GG6248@waste.org>
References: <20040405205539.GG6248@waste.org>
Content-Type: text/plain
Message-Id: <1081205099.15272.7.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 08:45:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 06:55, Matt Mackall wrote:
> Drop ksyms if we've built without module support
> 
> From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> Subject: Re: 2.6.1-rc1-tiny2

Other than saving a little compile time, does this actually do anything?

I'm not against it, I just don't think I see the point.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

