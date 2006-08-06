Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWHFP3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHFP3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHFP3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:29:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751082AbWHFP3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:29:55 -0400
Message-ID: <44D60B34.3020202@sgi.com>
Date: Sun, 06 Aug 2006 17:31:00 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andreas Schwab <schwab@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net> <1154702572.23655.226.camel@localhost.localdomain> <44D35B25.9090004@sgi.com> <1154706687.23655.234.camel@localhost.localdomain> <44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de> <44D370ED.2050605@sgi.com> <Pine.LNX.4.61.0608061126120.28841@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608061126120.28841@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> We know that today long is the only one that differs
> 
> For "modern architectures" maybe, but older compilers (like Turbo C 
> compiler (1990)), int is a 16 bit quantity, and therefore does differ, from 
> today's implementations at least.

Excuse me, but this conversation was about compiling the Linux kernel.
What non GCC compilers do is irrelevant to this.

Jes
