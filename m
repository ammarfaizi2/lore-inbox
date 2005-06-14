Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFNJls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFNJls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFNJls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:41:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3996 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261166AbVFNJln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:41:43 -0400
Date: Tue, 14 Jun 2005 11:40:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Using msleep() instead of HZ
Message-ID: <20050614094033.GA11673@elte.hu>
References: <42AEC01A.3060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AEC01A.3060403@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> Hi Andrew,
> Ingo suggested me to forward you my patches which do use of msleep in order to
> perform short delays instead of using HZ directly.
> I already sent him some, but they are against his -RT tree.
> This is a modified patch, built against 2.6.12-rc6.
> 
> Signed-off by: Luca Falavigna <dktrkranz@gmail.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
