Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTEGW5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTEGW5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:57:01 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38021
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264142AbTEGW5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:57:00 -0400
Subject: Re: [Linux-ia64] Re: [PATCH 2.5.69] IA64 sn mod_timer fixes for
	kernel/mca.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507191921.GA28137@sgi.com>
References: <1052283842.19524.44.camel@lima.royalchallenge.com>
	 <20030506225307.5ccb318f.akpm@digeo.com>  <20030507191921.GA28137@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052345462.3060.58.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 23:11:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 20:19, Jesse Barnes wrote:
> On Tue, May 06, 2003 at 10:53:07PM -0700, Andrew Morton wrote:
> > Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
> > >
> > > mca.c: Trivial {del,add}_timer to mod_timer conversion.
> > 
> > Please just roll all these up into one big patch.
> 
> Please also Cc: me on SN changes (and the big patch when you send it
> out).

You want to go through them one by one. Some are a bit less obvious and
a couple Im not sure about. Most are in my test -ac tree and seem fine

