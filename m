Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWIPQ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWIPQ1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWIPQ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:27:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:30890 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964828AbWIPQ1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:27:36 -0400
Message-ID: <450C25F5.1020307@garzik.org>
Date: Sat, 16 Sep 2006 12:27:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu> <450C1CF2.4080308@garzik.org> <20060916155141.GA18409@1wt.eu> <450C2134.7040200@garzik.org> <20060916160520.GB18409@1wt.eu>
In-Reply-To: <20060916160520.GB18409@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Of course for those. I was thinking about those which just change one
> register or things like this that I cannot identify the expected effect.
> If you agree, I'll enumerate the ones I've already noticed so that you
> just have to say yes/no/unknown on them. Don't worry, I don't want to
> spend lots of hours on this, since as I said, I do not receive any
> feedback from SATA users on 2.4 (neither positive nor negative).


I'm more than happy to review any 2.4 libata patches people post.

	Jeff


