Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUJFHuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUJFHuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJFHuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:50:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22483 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269100AbUJFHt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:49:57 -0400
Date: Wed, 6 Oct 2004 09:51:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041006075125.GA1710@elte.hu>
References: <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <32799.192.168.1.5.1096994246.squirrel@192.168.1.5> <20041005184226.GA10318@elte.hu> <32787.192.168.1.5.1097005084.squirrel@192.168.1.5> <20041005194458.GA15629@elte.hu> <1097021562.1359.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097021562.1359.5.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > i believe Andrew said that these USB problems should be fixed in the 
> > next -mm iteration.
> > 
> 
> FWIW, this one does not work for me either, I get a USB-related Oops
> on boot.

by next -mm iteration i meant -rc3-mm3, which is not released yet.

	Ingo
