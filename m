Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSGPPgo>; Tue, 16 Jul 2002 11:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSGPPgn>; Tue, 16 Jul 2002 11:36:43 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:747 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317904AbSGPPgm>; Tue, 16 Jul 2002 11:36:42 -0400
Date: Tue, 16 Jul 2002 17:39:26 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716153926.GR7955@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Gerhard Mack <gmack@innerfire.net>,
	Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-kernel@vger.kernel.org
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 11:11:20AM -0400, Gerhard Mack wrote:

> In other words you have a backup system that works some of the time or
> even most of the time... brilliant!

Dump is a backup system that works 100% of the time when used as 
it was designed to: on unmounted filesystems (or mounted R/O).

It is indeed brilliant to have it work, even most of the time,
in conditions it wasn't designed for.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
