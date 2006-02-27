Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWB0SLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWB0SLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWB0SLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:11:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60366 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751450AbWB0SLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:11:35 -0500
Date: Mon, 27 Feb 2006 19:04:33 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060227180433.GA20275@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <4402934B.7040506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4402934B.7040506@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Yep, you missed the data corruption fix (libata) and oops fix (netdev) 
> that I sent at 5pm EST today...

Expect a fix for a via-velocity bug when mtu > 1500 and a fix for
suspend/resume with the 8139cp driver later today.

-- 
Ueimor
