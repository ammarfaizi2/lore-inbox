Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbULRAdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbULRAdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbULRAdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:33:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262362AbULRAdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:33:43 -0500
Date: Sat, 18 Dec 2004 01:33:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] AFS: afs_voltypes isn't always required (fwd)
Message-ID: <20041218003340.GA21288@stusta.de>
References: <20041211165451.GT22324@stusta.de> <4659.1102949530@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4659.1102949530@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 02:52:10PM +0000, David Howells wrote:
> 
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > afs_voltypes is only used #ifdef __KDEBUG, and even then it doesn't has 
> > to be a global symbol.
> 
> I supposed I can always add this back with the next patch if I need it
> then. It's currently used for a /proc file in my under-development code.

Sure.

> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

