Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbUJ1G6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbUJ1G6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUJ1G5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:57:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14002 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262787AbUJ1G4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:56:52 -0400
Date: Thu, 28 Oct 2004 08:58:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028065806.GB10488@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu> <41801622.5040207@fbab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41801622.5040207@fbab.net>
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


* Magnus Naeslund(t) <mag@fbab.net> wrote:

> What information do you need to get something useful out of this? I
> saw that others have this problem, so I've got an serial console to
> the box, if you want me to do any tests, tell me how.

also, if you hit problems make sure you have the latest patch, i
sometimes upload a small update with a trivial fix without announcing it
(or the announcement lags on lkml), and i upload larger changes roughly
daily. The current latest version is RT-V0.4.3.

	Ingo
