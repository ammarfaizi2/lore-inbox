Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVKVMTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVKVMTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVKVMTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:19:30 -0500
Received: from anubis.fi.muni.cz ([147.251.54.96]:59576 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S964927AbVKVMT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:19:29 -0500
Date: Tue, 22 Nov 2005 13:18:02 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioscheduler and 2.6 kernels
Message-ID: <20051122121801.GB2529@mail.muni.cz>
References: <20051122115225.GA2529@mail.muni.cz> <4383078A.5010204@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4383078A.5010204@stud.feec.vutbr.cz>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 12:56:58PM +0100, Michal Schmidt wrote:
> >I have a question about ioschedulers in current 2.6 kernels. Is there an 
> >option
> >to build iorequest queues per process? I would like to have the queue for 
> >each
> >process and pick up request in round robin manner, which results in more
> >interactive environment. 
> 
> Isn't this exactly what the CFQ scheduler does?

Friend of me tried all the schedulers and he thinks, that all behave basicaly
the same. His testbed is to extract tar archive with lots small files and in
parallel to run xterm, which takes serious time. He wonder why.

For me it seems to be ok. Thanks.

-- 
Luká¹ Hejtmánek
