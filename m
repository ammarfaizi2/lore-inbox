Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVAELml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVAELml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAELlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:41:49 -0500
Received: from [213.146.154.40] ([213.146.154.40]:9617 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262336AbVAELjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:39:22 -0500
Date: Wed, 5 Jan 2005 11:39:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105113921.GA31416@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Steinmetz <ast@domdv.de>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, Jack O'Quin <joq@io.com>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DB4476.8080400@domdv.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me remind you all that according to lkml history hch has always been 
> biased and objecting to anything related to lsm. Nobody can take hch's 
> opinion here as objective. I would even go so far that when things are 
> related to lsm(s) he's just tro...

I'm not a big fan of LSM, and I've explained the rationale why multiple
times.  The doesn't mean everything done using LSM is bad  -  in practice
most things are bad though (from the things I've seen everything but lsm)

btw, any reason you drop me from the Cc list once you start the personal
attacks?
