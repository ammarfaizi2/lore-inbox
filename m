Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbUJ1Ssn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUJ1Ssn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUJ1Ssk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:48:40 -0400
Received: from mail.skule.net ([216.235.14.165]:3460 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S261970AbUJ1SsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:48:11 -0400
Date: Thu, 28 Oct 2004 14:47:45 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits - "@" question
Message-ID: <20041028184745.GC794@mjfrazer.org>
References: <200410230426.i9N4Qd9k004757@work.bitmover.com> <20041028174838.GA794@mjfrazer.org> <yw1xpt32lnhe.fsf@inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xpt32lnhe.fsf@inprovide.com>
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: They're great! They're like sex except I'm having them.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M?ns Rullg?rd <mru@inprovide.com> [04/10/28 14:18]:
> Why not just perl -pe 's/(.)/"&#".ord($1).";"/eg;' ?

even better...


-- 
I'm gonna be a science fiction hero, just like Uhura, or Captain Janeway,
or Xena! - Fry
