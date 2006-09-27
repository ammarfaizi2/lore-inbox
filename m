Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965575AbWI0LYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965575AbWI0LYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965576AbWI0LYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:24:33 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:58531 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S965575AbWI0LYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:24:32 -0400
Subject: Re: 2.6.18-mm1 compile failure on x86_64
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andi Kleen <ak@suse.de>, Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <451A5AD3.6060403@shadowen.org>
References: <45185A93.7020105@google.com>
	 <m1venaqeg6.fsf@ebiederm.dsl.xmission.com>
	 <20060927095839.GK20462@skl-net.de> <200609271226.44834.ak@suse.de>
	 <451A5AD3.6060403@shadowen.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 12:24:24 +0100
Message-Id: <1159356267.28313.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2006 11:24:32.0085 (UTC) FILETIME=[80E6D050:01C6E227]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 12:04 +0100, Andy Whitcroft wrote:

> In my testing, backing out the old patch and putting the one mentioned
> in the following message seems to work:
> 
> http://lists.xensource.com/archives/html/xen-devel/2006-08/msg01416.html

FWIW that's the same as applying
http://marc.theaimsgroup.com/?l=linux-kernel&m=115567883710134&w=2 over
the original patch, which is the fix I was talking about in my previous
mail.

Ian.


