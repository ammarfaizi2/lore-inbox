Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEHMqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTEHMqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:46:12 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:51460 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261311AbTEHMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:46:11 -0400
Date: Thu, 8 May 2003 13:58:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508135839.A6698@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
	Steffen Persvold <sp@scali.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052398474.4849.57.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Thu, May 08, 2003 at 02:54:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:54:35PM +0200, Terje Eggestad wrote:
> So what you're saying here is not that you object to having people doing
> syscall hooks, just that operating on the syscall_table symbol directly
> is error prone (to which I wholeheartedly agree). 
> 
> Then you reject a "proper mechanism".....

Maybe you have a different notion of proper mechanism then everyone
else.  BTW, you could easily have fixed your driver in the time you
spent trolling on lkml..

