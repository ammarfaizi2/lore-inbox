Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVCHVUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVCHVUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVCHVUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:20:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262349AbVCHVUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:20:40 -0500
Date: Tue, 8 Mar 2005 21:20:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, paul@linuxaudiosystems.com,
       mpm@selenic.com, joq@io.com, cfriesen@nortelnetworks.com,
       Chris Wright <chrisw@osdl.org>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308212027.GA17664@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, paul@linuxaudiosystems.com,
	mpm@selenic.com, joq@io.com, cfriesen@nortelnetworks.com,
	Chris Wright <chrisw@osdl.org>, arjanv@redhat.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308035503.GA31704@infradead.org> <20050307201646.512a2471.akpm@osdl.org> <20050308042242.GA15356@elte.hu> <20050307202821.150bd023.akpm@osdl.org> <20050308043250.GA32746@infradead.org> <1110308156.4401.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110308156.4401.4.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:55:55PM -0500, Lee Revell wrote:
> And as I mentioned a few times, the authors have neither the inclination
> nor the ability to do that, because they are not kernel hackers.  The
> realtime LSM was written by users (not developers) of the kernel, to
> solve a specific real world problem.  No one ever claimed it was the
> correct solution from the kernel POV.

And I told you that doesn't matter.  If someone wants a feature in they
should find a way to make it palable.  We're not accepting such excuses
to put in crap.

