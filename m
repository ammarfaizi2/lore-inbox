Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUCQUfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCQUfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:35:52 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:19328 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262026AbUCQUfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:35:46 -0500
Date: Wed, 17 Mar 2004 21:36:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: pingc@wacom.com, linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch
Message-ID: <20040317203658.GA369@ucw.cz>
References: <Pine.LNX.4.58L.0402262354190.1653@logos.cnet> <20040317092959.5e00fab4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317092959.5e00fab4.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 09:29:59AM -0800, Pete Zaitcev wrote:

> Dear Ping,
> 
> Vojtech posted your 2.6 patch to linux-kernel yesterday, so I examined it
> (Subject: [PATCH 32/44] Update of Wacom driver from Ping Cheng (from Wacom)).
> Unlike the 2.4 version, it does not feature a reset thread. Please tell
> me why that thread was required in 2.4.
> 
> Or perhaps it was present in your original submission which I lost and
> Vojtech removed that element of the patch?

I didn't remove it - it was not present in the 2.6 patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
