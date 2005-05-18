Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVERWCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVERWCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVERWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:02:06 -0400
Received: from colin.muc.de ([193.149.48.1]:13583 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262354AbVERWBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:01:39 -0400
Date: 19 May 2005 00:01:38 +0200
Date: Thu, 19 May 2005 00:01:38 +0200
From: Andi Kleen <ak@muc.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is needed to boot 2.6 on opteron dual core
Message-ID: <20050518220138.GC34459@muc.de>
References: <213219CA6232F94E989A9A5354135D2F0936FE@frqexc04.emea.cpqcorp.net> <m1br7a804l.fsf@muc.de> <428BB602.2040909@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428BB602.2040909@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you clarify that? I have to install one when it comes in to the 
> owner, and I'm not sure how you would do "runtime tuning" if it doesn't 
> boot. Did you mean boot parameters, BIOS diddling, or ???

What I meant to say is that all kernels should run on dual cores, but newer
ones likely have better performance. Nothing to do for the user.

-Andi
