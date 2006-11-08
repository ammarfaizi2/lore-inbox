Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWKHXd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWKHXd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161712AbWKHXd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:33:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:6815 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161343AbWKHXd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:33:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Thu, 9 Nov 2006 00:31:34 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090031.35069.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 10:54, Andrew Morton wrote:
> 
> Temporarily at
> 
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> 
> will turn up at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> 
> when kernel.org mirroring catches up.
> 
> 
> 
> - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
>   userspace tools, instructions, etc.
> 
>   It needs a recent binutils to build.
> 
> - The hrtimer+dynticks code still doesn't work right for machines which halt
>   their TSC in low-power states.

On my HPC nx6325 it doesn't even reach the point in which the messages become
visible on the console, so I'm unable to get any debug info from it.

Will do a binary search tomorrow (unless someone finds the solution before).

Greetings,
Rafael
