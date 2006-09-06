Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWIFO3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWIFO3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWIFO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:29:54 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:52029 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751144AbWIFO3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:29:53 -0400
Date: Wed, 6 Sep 2006 16:29:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Hua Zhong <hzhong@gmail.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Arjan van de Ven'" <arjan@infradead.org>
Subject: Re: lockdep oddity
Message-ID: <20060906142928.GF6898@osiris.boeblingen.de.ibm.com>
References: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com> <004901c6d18d$acc45620$0200a8c0@nuitysystems.com> <20060906084021.GA30856@elte.hu> <1157552359.3541.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157552359.3541.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 07:19:19AM -0700, Daniel Walker wrote:
> > the current code needs more work before it can go upstream i think.
> 
> It was never really planned to go upstream. It's ultimately a debugging
> feature that's really only needed in -mm .. 

And I thought the -mm tree was supposed to contain only code that will
go upstream sooner or later (unless it gets dropped for some reason).
