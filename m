Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWJ2VHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWJ2VHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWJ2VHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:07:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49298 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030269AbWJ2VHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:07:10 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer parameter names, some code motion
Date: Sun, 29 Oct 2006 13:06:35 -0800
User-Agent: KMail/1.9.1
Cc: Don Mullis <dwm@meer.net>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1161920325.17807.29.camel@localhost.localdomain> <1161920728.17807.39.camel@localhost.localdomain> <1162152071.23311.28.camel@localhost.localdomain>
In-Reply-To: <1162152071.23311.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610291306.36148.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 12:01, Don Mullis wrote:
> Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.
>
> Tested by build and boot.

What error does that fix?

-Andi
