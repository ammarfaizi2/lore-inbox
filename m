Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131551AbRBUFxp>; Wed, 21 Feb 2001 00:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRBUFxg>; Wed, 21 Feb 2001 00:53:36 -0500
Received: from [63.68.113.130] ([63.68.113.130]:41663 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S131551AbRBUFx1>;
	Wed, 21 Feb 2001 00:53:27 -0500
Date: Tue, 20 Feb 2001 21:52:21 -0800
To: pf-kernel@mirkwood.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: loopback mount broken in 2.4.2-pre4
Message-ID: <20010220215221.A27945@osdlab.org>
In-Reply-To: <Pine.LNX.4.20.0102210033040.401-100000@eriador.mirkwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.20.0102210033040.401-100000@eriador.mirkwood.net>; from pf-kernel@mirkwood.net on Wed, Feb 21, 2001 at 12:36:34AM -0500
From: Nathan Dabney <smurf@osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 12:36:34AM -0500, pf-kernel@mirkwood.net wrote:
> The subject gives just about all the information I have.  :)  If I try to
> mount an iso image via loopback while running 2.4.2-pre4, mount will hang
> forever.  Downgrading to 2.4.1 seems to resolve the issue (haven't tried
> any previous -pre patches).

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/

-Nathan
