Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUITDik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUITDik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 23:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUITDik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 23:38:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:46781 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265970AbUITDii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 23:38:38 -0400
Subject: Re: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040919202126.1073925b@lembas.zaitcev.lan>
References: <mailman.1095300780.10032.linux-kernel2news@redhat.com>
	 <20040917002935.77620d1d@lembas.zaitcev.lan>
	 <1095414394.13531.77.camel@gaston>
	 <20040917090448.32ff763c@lembas.zaitcev.lan>
	 <1095469463.3574.2.camel@gaston> <1095473325.3574.4.camel@gaston>
	 <20040919202126.1073925b@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1095651446.31131.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 13:37:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-20 at 13:21, Pete Zaitcev wrote:

> How about this deal. I'll add a clearly marked workaround like the
> appended patch, and then ask you to try again when a proper spin-up gets
> implemented?

Ok, I'll give it a try, but you don't need to call it "benh's key" :) I
think everybody at kernel summit got one of those no ? :)

Ben.

> Note that the patch is against -mm where the REQUEST SENSE is set correctly.
> I strongly suggest you to use ub from -mm. Linus' tree is behind.
> 
> Also, I might have screwed something along the way, so if it fails, please
> send me dmesg and the contents of /sys/..../diag.

I will later today or tomorrow, thanks !

Ben.


