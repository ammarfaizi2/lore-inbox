Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269740AbUJVOGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269740AbUJVOGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUJVOGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:06:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39632 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269740AbUJVOFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:05:43 -0400
Date: Fri, 22 Oct 2004 16:07:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "K.R. Foley" <kr@cybsft.com>, "J.A. Magallon" <jamagallon@able.es>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
Message-ID: <20041022140701.GC8120@elte.hu>
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com> <41668346.6090109@adaptec.com> <20041022135800.GA8254@elte.hu> <41791302.5030305@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41791302.5030305@adaptec.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luben Tuikov <luben_tuikov@adaptec.com> wrote:

> Have you tried this with the latest scsi-misc-2.6 tree?  The PCI table
> patches are there.
> 
> If you have _and_ it still does not work, can you send output of
> "lspci -vn"?

no, i havent. Is it easy to apply that tree to 2.6.9-rc4-mm1?

	Ingo
