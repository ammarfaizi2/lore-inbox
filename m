Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936046AbWK2UMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936046AbWK2UMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936056AbWK2UMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:12:33 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:56777 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S936046AbWK2UMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:12:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Date: Wed, 29 Nov 2006 21:08:00 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tulip-users@lists.sourceforge.net
References: <20061128020246.47e481eb.akpm@osdl.org> <200611292054.35313.rjw@sisk.pl>
In-Reply-To: <200611292054.35313.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292108.00578.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 29 November 2006 20:54, Rafael J. Wysocki wrote:
> On Tuesday, 28 November 2006 11:02, Andrew Morton wrote:
> > 
> > Temporarily at
> > 
> > http://userweb.kernel.org/~akpm/2.6.19-rc6-mm2/
> > 
> > Will appear eventually at
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> 
> A minor issue: on one of my (x86-64) test boxes the uli526x driver doesn't
> work when it's first loaded.  I have to rmmod and modprobe it to make it work.
> 
> It worked just fine on -mm1, so something must have happened to it recently.

Sorry, I was wrong.  The driver doesn't work at all, even after reload.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
