Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVIPXEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVIPXEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVIPXEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:04:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4741 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750761AbVIPXEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:04:22 -0400
Subject: Re: R52 hdaps support?
From: Robert Love <rml@novell.com>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432B34D6.6010904@gmail.com>
References: <432B34D6.6010904@gmail.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 19:04:20 -0400
Message-Id: <1126911860.24266.1.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 17:10 -0400, Keenan Pepper wrote:

> I recently splurged on a new ThinkPad R52 (because it was one of the few laptops 
> in the store with /all/ linux-supported hardware), but the 2.6.14-rc1 kernel I 
> just compiled says "hdaps: supported laptop not found".
> 
> Looking at the source I notice there's a whitelist of models that goes up to 
> R51... How badly could it break if I just went ahead and added R52? Should it be 
> "NORMAL" or "INVERT"?


The R52 should work and nothing should break.  If it works, I'll add it.

As for normal versus inverted: You probably want NORMAL, but you will
have to verify it and let me know.  You'll know you have the wrong one
when the readings are, well, inverted.

	Robert Love


