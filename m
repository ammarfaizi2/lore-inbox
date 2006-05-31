Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWEaUjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWEaUjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWEaUjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:39:17 -0400
Received: from es335.com ([67.65.19.105]:65372 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S964847AbWEaUjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:39:15 -0400
Subject: Re: [PATCH 1/7] AMSO1100 Makefiles and Kconfig changes.
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada8xoix76r.fsf@cisco.com>
References: <20060531182733.3652.54755.stgit@stevo-desktop>
	 <20060531182735.3652.44197.stgit@stevo-desktop> <ada8xoix76r.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 15:39:13 -0500
Message-Id: <1149107953.7469.9.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 13:36 -0700, Roland Dreier wrote:
> Can you reorder things so these changes go last?  Otherwise after this
> patch we're left with a kernel tree that has a Makefile that refers to
> sources that don't exist yet.  It's not really a practical issue but
> it is neater to do that way.
> 
> (It's easy to do in stgit -- just pop all the patches and then use
> "stg push <name>" to push them in a different order)
> 
>  - R.

will do.


