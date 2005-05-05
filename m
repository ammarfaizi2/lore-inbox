Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVEEUON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVEEUON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVEETdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:33:06 -0400
Received: from solarneutrino.net ([66.199.224.43]:55558 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S262195AbVEESlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:41:49 -0400
Date: Thu, 5 May 2005 14:41:47 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: DRI lockup on R200, 2.6.11.7
Message-ID: <20050505184147.GA13505@tau.solarneutrino.net>
References: <20050426202916.GA2635@xarello> <21d7e99705042801227ed5438e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d7e99705042801227ed5438e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:22:36AM +0100, Dave Airlie wrote:
> 2.6.12 should fix this, there is patch at:
> http://drm.bkbits.net:8080/drm-linus/gnupatch@424260f9PBUdlFvyiQw1maJBKvEtXA

Another crash today, same thing.  It seems to have made it less common,
though (maybe).  One thing that was different was that this time killing
X didn't reset the machine.

-ryan
