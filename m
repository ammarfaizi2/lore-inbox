Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUKBMwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUKBMwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUKBMvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:51:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44960 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261543AbUKBMrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:47:21 -0500
Date: Tue, 2 Nov 2004 13:48:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove sleep-avg stats
Message-ID: <20041102124824.GG15290@elte.hu>
References: <41871BB1.6020001@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41871BB1.6020001@kolivas.org>
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

> remove sleep-avg stats

actually, i'd like to keep this one some more, _especially_ now that we
are likely to testdrive your patchset in -mm :-)

	Ingo


