Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVEKHUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVEKHUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEKHUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:20:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46735 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261915AbVEKHUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:20:19 -0400
Date: Wed, 11 May 2005 09:20:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: AndrewMorton <akpm@osdl.org>, Carlos Carvalho <carlos@fisica.ufpr.br>,
       ck@vds.kolivas.org, Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [SMP NICE] [PATCH 2/2] SCHED: Make SMP nice a config option
Message-ID: <20050511072007.GB4718@elte.hu>
References: <20050509112446.GZ1399@nysv.org> <17023.63512.319555.552924@fisica.ufpr.br> <200505111304.06853.kernel@kolivas.org> <200505111305.48610.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505111305.48610.kernel@kolivas.org>
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


ack on the first patch - but please dont make it a .config option!  
Either it's good enough so that everyone can use it, or it isnt.

	Ingo
