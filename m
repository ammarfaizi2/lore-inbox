Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUKBMmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUKBMmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUKBMmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:42:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49565 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261534AbUKBMjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:39:46 -0500
Date: Tue, 2 Nov 2004 13:40:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] adjust timeslice granularity
Message-ID: <20041102124050.GD15290@elte.hu>
References: <418707DE.70706@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418707DE.70706@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> adjust timeslice granularity

this too is of the 'could potentially hurt interactivity' type and needs
-mm exposure and is 2.6.11 material at the earliest. Looks good and
sound otherwise.

	Ingo


