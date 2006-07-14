Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWGNLI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWGNLI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWGNLI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:08:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29869 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161078AbWGNLI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:08:27 -0400
Message-ID: <44B77B1A.6060502@garzik.org>
Date: Fri, 14 Jul 2006 07:08:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: greg@kroah.com, akpm@osdl.org, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>
In-Reply-To: <20060714095233.5678A8B6253@zog.reactivated.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 regression:
> new kernels will not boot their system from their VIA SATA hardware.
> 
> The solution is just to add the SATA device to the fixup list.
> This should also fix the same problem reported by Scott J. Harmon on LKML.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Same NAK comment as before...

	Jeff



