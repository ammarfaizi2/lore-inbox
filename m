Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVAEL2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVAEL2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVAEL0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:26:36 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48528 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262333AbVAELZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:25:17 -0500
Date: Wed, 5 Jan 2005 11:25:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105112516.GA31119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, Jack O'Quin <joq@io.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104865198.8346.8.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:59:57PM -0500, Lee Revell wrote:
> We could do it the was OSX (our real competition) does if that would
> make people happy.  They just let any user run RT tasks.  Oh wait, but
> that's a "broken design", everyone knows that OSX is a joke, no one
> would use *that* OS to mix a CD or score a movie.  :-)

No one sane (well, no one sane with a background in Operating Systems)
would use OS X at all.

