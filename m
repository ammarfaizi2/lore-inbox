Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFRTV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFRTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVFRTVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:21:25 -0400
Received: from atpro.com ([12.161.0.3]:56845 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261291AbVFRTVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:21:18 -0400
Date: Sat, 18 Jun 2005 15:20:33 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12
Message-ID: <20050618192033.GD24148@mail>
Mail-Followup-To: Nick Warne <nick@linicks.net>,
	linux-kernel@vger.kernel.org
References: <200506182005.28254.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506182005.28254.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/05 08:05:28PM +0100, Nick Warne wrote:
> 
> Heh.  When I was sussing 2.6.12 stuff today, I really thought it was me 
> buggering up something.  So after reading a lot, I wondered (neurotically)  
> if I was doing anything wrong (after all this time, it's likely).
> 
> > make help reveals:
> 
>  randconfig      - New config with random answer to all options
> 
> So 'make randconfig' is the one to use!  What one earth is that for?

Weeding out dependencies that aren't in the make system yet.

> 
> Nick

Jim.
