Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTEGTGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbTEGTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:06:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:26345 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264203AbTEGTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:06:47 -0400
Date: Wed, 7 May 2003 12:19:21 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: [PATCH 2.5.69] IA64 sn mod_timer fixes for kernel/mca.c
Message-ID: <20030507191921.GA28137@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1052283842.19524.44.camel@lima.royalchallenge.com> <20030506225307.5ccb318f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506225307.5ccb318f.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:53:07PM -0700, Andrew Morton wrote:
> Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
> >
> > mca.c: Trivial {del,add}_timer to mod_timer conversion.
> 
> Please just roll all these up into one big patch.

Please also Cc: me on SN changes (and the big patch when you send it
out).

Thanks,
Jesse
