Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFNHdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFNHdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFNHdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:33:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63724 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261304AbVFNHdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:33:01 -0400
Date: Tue, 14 Jun 2005 09:20:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: Serge Noiraud <serge.noiraud@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Message-ID: <20050614072015.GA31891@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F36732323B@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732323B@MAILIT.keba.co.at>
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


* kus Kusche Klaus <kus@keba.com> wrote:

> I was one of those who tried to get kgdb working.
> 
> Here I described how far I came:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0505.1/0700.html

does ethernet debugging work if you disable the netpoll WARN_ON() that 
triggers?

	Ingo
