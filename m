Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVBMNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVBMNfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVBMNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:35:30 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48807 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261186AbVBMNf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:35:27 -0500
Date: Sun, 13 Feb 2005 14:30:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050213133020.GA16363@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net> <20050213130058.GA566@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213130058.GA566@zaniah>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Philippe Elie <phil.el@wanadoo.fr> wrote:

> oprofile_ops.cpu_type == NULL, this has been fixed 3 weeks ago, can
> you retry with -rc4 ?

i've uploaded an -rc4 port of the -RT tree half an hour ago (-39-00).

	Ingo
