Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbVAFWi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbVAFWi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVAFWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:35:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38588 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263151AbVAFWd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:33:59 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DD9968.7070004@comcast.net>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105045853.17176.273.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 21:29:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 20:02, John Richard Moser wrote:
> experiments have no place in production; if your "stable" mainline
> branch is going to continuously add and remove features and go through
> wild API and functionality changes, nobody is going to want to use it.
> Mozilla doesn't support IE's broken crap "because IE is a moving
> target."  Unpredictable API changes and changes to the deep inner

IE hasn't moved in years. The inventiveness of the bad web page authors
might be unbounded 8)

> workings of the kernel will make the kernel "a moving target."  If
> that's the route you take, it will become too difficult for people to
> develope for linux.

Its also impossible to do development if none of the changes you make
get into the kernel for stability reasons ever. Its a double edged
sword. For most end users it is about distribution kernels not the base.


