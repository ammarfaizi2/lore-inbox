Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVAETMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVAETMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVAETMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:12:07 -0500
Received: from [213.146.154.40] ([213.146.154.40]:41369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262560AbVAETLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:11:49 -0500
Date: Wed, 5 Jan 2005 19:11:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105191147.GB5720@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, Andreas Steinmetz <ast@domdv.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, Jack O'Quin <joq@io.com>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <20050105113921.GA31416@infradead.org> <1104946557.8589.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104946557.8589.32.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 12:35:56PM -0500, Lee Revell wrote:
> On Wed, 2005-01-05 at 11:39 +0000, Christoph Hellwig wrote:
> > I'm not a big fan of LSM, and I've explained the rationale why multiple
> > times.  The doesn't mean everything done using LSM is bad  -  in practice
> > most things are bad though (from the things I've seen everything but lsm)
>                                                                        ^^^
> 
> Is this a typo?  Maybe you mean SELinux?

Yes.

