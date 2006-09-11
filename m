Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWIKPY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIKPY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWIKPY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:24:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57526 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964881AbWIKPYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:24:25 -0400
Message-ID: <45057FA3.4000509@garzik.org>
Date: Mon, 11 Sep 2006 11:24:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <4505694D.5020304@garzik.org> <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It's not even like you'd get magically higher performance by using 256 
> sectors, so there's simply no win from living dangerously. Only losses.

It's easy enough to change.  Does this mean you want drivers/ide changed 
too?  It's apparently been living dangerously for years and years.

	Jeff


