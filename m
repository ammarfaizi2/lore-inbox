Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVCCV6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVCCV6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVCCVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:50:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:41134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262613AbVCCVtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:49:22 -0500
Subject: Re: RFD: Kernel release numbering
From: John Cherry <cherry@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303052100.GA22952@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
	 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	 <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org>
	 <20050303052100.GA22952@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 13:49:50 -0800
Message-Id: <1109886590.24056.33.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 00:21 -0500, Dave Jones wrote:
<snip>
> compile time regressions we should be able to nail down fairly easily.
> (someone from OSDL is already doing compile stats and such on each release
>  [too bad they're mostly incomprehensible to the casual viewer])

Dave, I'm the "someone from OSDL".  I agree that the compile stats and
error/warning regresssions can be a little challenging to grock for the
casual observer.  Is it content or formatting that would help the casual
viewer?

John

> The bigger problem is runtime testing. If things aren't getting the
> exposure they need, we're going to get screwed over by something or other
> every time Linus bk pull's some random driver repo.
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

