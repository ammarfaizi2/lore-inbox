Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUK2Tys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUK2Tys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUK2Tyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:54:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35712 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261765AbUK2TyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:54:19 -0500
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM 1/10: Base CKRM Events 
In-reply-to: Your message of Mon, 29 Nov 2004 20:32:26 +0100.
             <20041129193226.GA8397@mars.ravnborg.org> 
Date: Mon, 29 Nov 2004 11:40:53 -0800
Message-Id: <E1CYrOH-0006gX-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 20:32:26 +0100, Sam Ravnborg wrote:
> 
> Plase make this:
> 
> obj-y := ckrm_events.o
> 
> And this:
> obj-$(CONFIG_CKRM) += ckrm/
> 
> 	Sam

Great - will do.

thanks!

gerrit
