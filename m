Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVBGL5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVBGL5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVBGL5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:57:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11924 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261402AbVBGL5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:57:45 -0500
Date: Mon, 7 Feb 2005 12:57:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050207115736.GB22948@elte.hu>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124121729.GA29392@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124121729.GA29392@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > inotify.patch
> >   inotify

> Also ioctl is not an acceptable interface for adding new core
> functionality.

seconded. Robert?

	Ingo
