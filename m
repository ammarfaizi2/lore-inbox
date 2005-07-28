Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVG1BoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVG1BoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVG1BoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:44:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261205AbVG1BnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:43:01 -0400
Date: Wed, 27 Jul 2005 18:41:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: tony.luck@intel.com, ambx1@neo.rr.com, greg@kroah.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050727184144.27aae085.akpm@osdl.org>
In-Reply-To: <42E836F5.2050803@jp.fujitsu.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03FCF24C@scsmsx401.amr.corp.intel.com>
	<42E836F5.2050803@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>
> After all, I think ia64-halt-hangup-fix.patch should be removed
>  from -mm tree.

yup, I already tested-and-dropped it, thanks.
