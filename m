Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTISLNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 07:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTISLNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 07:13:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57230 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261507AbTISLNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 07:13:00 -0400
Date: Fri, 19 Sep 2003 13:12:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix keycode for rctrl in scancode set 3
Message-ID: <20030919111252.GB375@ucw.cz>
References: <UTC200309182334.h8INYxg18389.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200309182334.h8INYxg18389.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 01:34:59AM +0200, Andries.Brouwer@cwi.nl wrote:

> By mistake the keycode for right control in scancode set 3
> was the same as that for right alt. This fixes that.

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
