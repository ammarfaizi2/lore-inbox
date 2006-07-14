Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWGNNpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWGNNpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWGNNpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 09:45:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:47281 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030448AbWGNNpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 09:45:49 -0400
Message-ID: <44B7A007.2010204@garzik.org>
Date: Fri, 14 Jul 2006 09:45:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: jdike@karaya.com
CC: user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: UML build broken everywhere?
References: <44B79AB9.3020401@garzik.org>
In-Reply-To: <44B79AB9.3020401@garzik.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I tried to build 2.6.17 and 2.6.17.4 UML on x86-64 with the attached 
> .config on a Fedora Core 5 OS, and it broke:

I just verified that ARCH=um on 32-bit x86 is also broken, with the same 
build errors, on 2.6.17, 2.6.17.4, and 2.6.18-rc1-gitX (latest).

	Jeff



