Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264812AbSJOXmA>; Tue, 15 Oct 2002 19:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264891AbSJOXmA>; Tue, 15 Oct 2002 19:42:00 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:45839 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264812AbSJOXmA>; Tue, 15 Oct 2002 19:42:00 -0400
Date: Wed, 16 Oct 2002 00:47:49 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/7] oprofile - dcookies
Message-ID: <20021015234749.GA45125@compsoc.man.ac.uk>
References: <20021015223255.GB41906@compsoc.man.ac.uk> <20021015.163749.38782953.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015.163749.38782953.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181bPh-000EO6-00*oDImOygbI1A* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:37:49PM -0700, David S. Miller wrote:

> Can you make the dcookie a fixed sized type such
> as "u32" so we don't have headaches translating this
> system call for 32-bit apps on 64-bit systems?

Ah, yes. I'll submit a followup patch soon...

regards
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
