Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWJNJtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWJNJtY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 05:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWJNJtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 05:49:24 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:18140 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751697AbWJNJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 05:49:23 -0400
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
From: Arjan van de Ven <arjan@linux.intel.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net,
       Ryan Richter <ryan@tau.solarneutrino.net>
In-Reply-To: <4530A613.40007@tungstengraphics.com>
References: <20061013194516.GB19283@tau.solarneutrino.net>
	 <4530A613.40007@tungstengraphics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 11:49:10 +0200
Message-Id: <1160819350.15683.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 09:55 +0100, Keith Whitwell wrote:
> Your drm module is out of date.


Since the reporter is using the latest brand spanking new kernel, that
is highly unlikely unless something else in the software universe is
assuming newer-than-brand-spanking-new.

