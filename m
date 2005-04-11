Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVDKPcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVDKPcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVDKPcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:32:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50622 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261805AbVDKPcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:32:12 -0400
Date: Mon, 11 Apr 2005 17:31:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411153135.GA7051@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411152815.GB5562@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411152815.GB5562@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> here are some stats: of the last 34160 files modified in the Linux 
> kernel tree in the past 1 year, the file sizes total to 1 GB, and the 
> average file-size per file committed is 31220 bytes. The changes 
> themselves amount to:
> 
>  22404 files changed, 1996494 insertions(+), 1396644 deletions(-)
> 
> (the # of files changed is lower because one file can be modified 
> multiple times)

one more number: thus the average commit size is 3575 bytes, i.e. less 
than a block.

	Ingo
