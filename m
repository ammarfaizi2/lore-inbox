Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCHFjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCHFjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCHFjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:39:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39659 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261248AbVCHFjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:39:19 -0500
Date: Tue, 8 Mar 2005 06:38:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       joq@io.com, cfriesen@nortelnetworks.com, chrisw@osdl.org,
       hch@infradead.org, rlrevell@joe-job.com, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308053842.GB19528@elte.hu>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308043349.GG3120@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> Add a pair of rlimits for allowing non-root tasks to raise nice and rt
> priorities. Defaults to traditional behavior. Originally written by
> Chris Wright.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>

this too looks good to me.

  Acked-by: Ingo Molnar <mingo@elte.hu>

(no strong feelings either way, other than rlimits feel a bit less
hackish.)

	Ingo
