Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVCaCUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVCaCUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCaCUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:20:22 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:15034 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S262485AbVCaCUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:20:10 -0500
Message-ID: <424B5E51.2040709@tlinx.org>
Date: Wed, 30 Mar 2005 18:20:01 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: 2.6.release.patchlevel:  Patch against 2.6.release[.0] ?
References: <4249DC03.4000806@tlinx.org> <20050329230436.GQ28536@shell0.pdx.osdl.net>
In-Reply-To: <20050329230436.GQ28536@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright wrote:
> The patches on kernel.org in v2.6/ are already against the base (i.e.
> patch-2.6.11.6.bz2 is against 2.6.11).  The patches in v2.6/incr/
> are incremental between -stable releases (i.e. patch-2.6.11.5-6.bz2 is
> against 2.6.11.5).
----
	I see.  I had looked at the "Changelog" page on the www.kernel.org home
page and only saw changes from 2.6.11.5->2.6.11.6 documented.  I thought that 
the Changelog documented the changes that were in the patch.

	Maybe Changlog's that only document the current increment should be in the 
"incr" directory as well and be named "Changelog-2.6.11.5-6" (for the current 
change log, while a cumulative change log from the base version should
be kept in the v2.6 dir?

	I think having the Changelog link on the main page only documenting
the latest "incr", but having the patch containing everything from the base is
confusing.  Am I the only one who might expect the Changelog to document what is
in the given increment, but the associated patch includes everything since the base?

	It's a "nit", I know, but I prefer having the change-log and patch to match 
w/respect to content.

Linda
