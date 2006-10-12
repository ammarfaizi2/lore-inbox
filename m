Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWJLU3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJLU3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJLU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:29:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWJLU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:29:19 -0400
Subject: Re: Can context switches be faster?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <452EA441.6070703@comcast.net>
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com>
	 <452EA441.6070703@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 22:29:14 +0200
Message-Id: <1160684954.3000.473.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ther uniprocessor machines.
> > 
> 
> That's a load more descriptive :D
> 
> 0.890 uS, 0.556uS/cycle, that's barely 2 cycles you know.  (Pentium M)
> PPC performs similarly, 1 cycle should be about 1uS.
> 
> > Chris

you have your units off; 1 cycle is 1 nS not 1 uS  (or 0.556 nS for the
pM)

