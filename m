Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUCWLdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUCWLdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:33:03 -0500
Received: from rootsrv.net ([217.160.131.12]:23449 "HELO rootsrv.net")
	by vger.kernel.org with SMTP id S262499AbUCWLdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:33:01 -0500
Message-ID: <406020A1.3000600@pop2wap.net>
Date: Tue, 23 Mar 2004 12:33:53 +0100
From: Christof <mail@pop2wap.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: synchronous serial port communication (16550A)
References: <1CRaT-Zx-3@gated-at.bofh.it> <1CRun-1dV-41@gated-at.bofh.it>
In-Reply-To: <1CRun-1dV-41@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> You could write a byte, wait for it to complete by calling ioctl(TCSETSW)
> without changing any parameters, and then read the CTS status.
I'm away for 2 days now, so I will try it when I will be back home.
Thank you!

--
Regards,
   Christof Krueger

