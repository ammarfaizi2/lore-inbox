Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279645AbRJXXiG>; Wed, 24 Oct 2001 19:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279647AbRJXXhv>; Wed, 24 Oct 2001 19:37:51 -0400
Received: from ns.suse.de ([213.95.15.193]:17165 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279645AbRJXXhh>;
	Wed, 24 Oct 2001 19:37:37 -0400
Date: Thu, 25 Oct 2001 01:38:12 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Mike <maneman@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Machine Check Exception in >2.4.5: Where to comment MCE out?
In-Reply-To: <3BD74E4C.8A9BB52C@gmx.net>
Message-ID: <Pine.LNX.4.30.0110250136360.3197-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Mike wrote:

> ... various disable MCE stuff..

You don't need to recompile your kernel. You can boot with 'nomce'
as an argument, and the code gets disabled.

This has been in -ac, and -linus for a few revisions now.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

