Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVGLOsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVGLOsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGLOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:47:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3309 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261471AbVGLOqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:46:51 -0400
Date: Tue, 12 Jul 2005 16:46:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050712144645.GA21517@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712142828.GA20798@elte.hu> <1121178696.10199.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121178696.10199.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> I haven't tested it recently . This was on an older version of RT 
> though . I could try it if it's interesting ? Or do you think it's 
> already fixed?

it would be definitely interesting to see how robust the latest IO-APIC 
code is.

	Ingo
