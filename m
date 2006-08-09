Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWHIVw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWHIVw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHIVw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:52:28 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:6572 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751377AbWHIVw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:52:28 -0400
Date: Wed, 9 Aug 2006 17:45:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@suse.cz>, Josh Boyer <jwboyer@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608091749_MC3-1-C796-5E8D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060808195509.GR3691@stusta.de>

On Tue, 8 Aug 2006 21:55:10 +0200, Adrian Bunk wrote:

> > > > I believe I had 'fix pdflush after suspend' queued in Greg's tree. Is
> > > > it still queued or should I resend?
> > > 
> > > Is this "pdflush: handle resume wakeups"?
> > 
> > Yes. Do you have it somewhere or should I dig it up?
> 
> I've applied it.

Umm, is there some place we can check to see what you've applied?

I sent you "tty: serialize flush_to_ldisc" and I've got a few more
but I don't want to duplicate what you already have.

-- 
Chuck

