Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUD1U26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUD1U26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUD1U0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:26:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:58805 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262045AbUD1UXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:23:47 -0400
Date: Wed, 28 Apr 2004 13:22:56 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: raven@themaw.net, pj@sgi.com, erdi.chen@digeo.com, davem@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
Message-ID: <20040428202256.GB24942@kroah.com>
References: <20040426204947.797bd7c2.pj@sgi.com> <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au> <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net> <Pine.LNX.4.58.0404280111430.2125@skynet> <20040427202520.017e4591.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427202520.017e4591.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:25:20PM -0700, Randy.Dunlap wrote:
> 
> The USB hubstatus part of the patch looked correct to me.
> Greg, do you already have a s/hubstatus/devstat/ in hub.c,
> near line 1343?

David Brownell already sent me a patch to fix this issue.

thanks,

greg k-h
