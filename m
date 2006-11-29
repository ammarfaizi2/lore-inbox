Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967618AbWK2T7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967618AbWK2T7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967622AbWK2T7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:59:08 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:49353 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S967618AbWK2T7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:59:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Date: Wed, 29 Nov 2006 20:54:34 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tulip-users@lists.sourceforge.net
References: <20061128020246.47e481eb.akpm@osdl.org>
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292054.35313.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 28 November 2006 11:02, Andrew Morton wrote:
> 
> Temporarily at
> 
> http://userweb.kernel.org/~akpm/2.6.19-rc6-mm2/
> 
> Will appear eventually at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/

A minor issue: on one of my (x86-64) test boxes the uli526x driver doesn't
work when it's first loaded.  I have to rmmod and modprobe it to make it work.

It worked just fine on -mm1, so something must have happened to it recently.

Greetings,
Rafael
