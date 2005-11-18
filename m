Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbVKRSWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVKRSWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVKRSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:22:13 -0500
Received: from kanga.kvack.org ([66.96.29.28]:25013 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1161050AbVKRSWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:22:13 -0500
Date: Fri, 18 Nov 2005 13:19:45 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: John Jasen <jjasen@realityfailure.org>
Cc: Bharath Ramesh <krosswindz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intel8x0 sound of silence on dell system
Message-ID: <20051118181945.GB22566@kvack.org>
References: <20051118162300.GA22092@kvack.org> <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com> <20051118180410.GA22566@kvack.org> <Pine.LNX.4.63.0511181310410.23989@bushido>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511181310410.23989@bushido>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 01:11:52PM -0500, John Jasen wrote:
> You can try adding buggy_irq=1, buggy_semaphore=1 or both to your 
> modprobe.conf file, and see if any of those help. It did in my case.

Doesn't seem to have an effect here.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
