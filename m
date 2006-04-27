Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWD0U5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWD0U5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWD0U5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:9662 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751656AbWD0U47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:56:59 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Date: Thu, 27 Apr 2006 21:56:11 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com>
In-Reply-To: <44512B61.4040000@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272156.11606.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 22:36, Martin Bligh wrote:


>
> > - Matches kernel coding style(!)
>
> E_NEEDS_AUTOMATED_FILTER / lint of some form.

Some Unixes have a cstyle(1). Maybe there is a free variant of it somewhere.
But such a tool might put a lot of people on l-k out of job @)

> The others all look doable.
>
> The intent would not be that you get burdened with this, but that
> developers send it there before sending it to you. It could even
> hand out

It would be better to automate this - not require the developers
to do lots of manual steps.

-Andi

