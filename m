Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVBGJw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVBGJw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBGJwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:52:44 -0500
Received: from styx.suse.cz ([82.119.242.94]:21639 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261387AbVBGJwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:52:40 -0500
Date: Mon, 7 Feb 2005 10:53:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch] ns558 bug
Message-ID: <20050207095330.GD5685@ucw.cz>
References: <4203D476.4040706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203D476.4040706@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 09:00:54PM +0100, matthieu castet wrote:
> Hi,
> 
> this patch is based on http://bugzilla.kernel.org/show_bug.cgi?id=2962 
> patch from adam belay.
> 
> It solve a oops when pnp_register_driver(&ns558_pnp_driver) failed.
> 
> Please apply this patch.

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
