Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSHMQlG>; Tue, 13 Aug 2002 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHMQlG>; Tue, 13 Aug 2002 12:41:06 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:26886 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S318254AbSHMQlF>; Tue, 13 Aug 2002 12:41:05 -0400
Date: Tue, 13 Aug 2002 17:44:53 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020813164453.GA8898@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain> <20020813164415.A11554@infradead.org> <20020813160924.GA3821@codepoet.org> <20020813171138.A12546@infradead.org> <15705.13490.713278.815154@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15705.13490.713278.815154@napali.hpl.hp.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:32:50AM -0700, David Mosberger wrote:

> clone() should have specified a stack memory *area* from the
> beginning.  (UNIX got this right from the beginning, see, e.g.,
> sigaltstack()).

doesn't sigstack() predate that :)

regards
john

-- 
"It is unbecoming for young men to utter maxims."
	- Aristotle
