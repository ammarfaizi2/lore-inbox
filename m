Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUHRB45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUHRB45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUHRB45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:56:57 -0400
Received: from [12.177.129.25] ([12.177.129.25]:38083 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268575AbUHRB44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:56:56 -0400
Date: Tue, 17 Aug 2004 22:58:30 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-ID: <20040818025830.GB1013@ccure.user-mode-linux.org>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org> <20040816220816.1b30fd53.akpm@osdl.org> <200408171915.i7HJF5KF003348@ccure.user-mode-linux.org> <20040817112629.04c7f672.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817112629.04c7f672.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 11:26:29AM -0700, Andrew Morton wrote:
> Frankly, when a subsystem gets this far out of date I don't think it
> matters a lot - nobody has much hope of following all the changes anyway. 
> We'll just merge the megapatch on the assumption that Jeff knows what he's
> doing, and that it's better than what we had before.  

Well, that latter is pretty certain, but I wouldn't be too sure about the
former :-)

> You should have seen
> the size of some of those MIPS patches ;)

Hehe.  OK, I'll keep the current big patch, and stack little ones on top of
it to fix it.

				Jeff
