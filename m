Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWD0VM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWD0VM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWD0VM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:12:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:51391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751679AbWD0VM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:12:28 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Date: Thu, 27 Apr 2006 22:11:41 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <200604272156.11606.ak@suse.de> <445130E7.3060402@google.com>
In-Reply-To: <445130E7.3060402@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272211.41923.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 23:00, Martin Bligh wrote:
> > Some Unixes have a cstyle(1). Maybe there is a free variant of it
> > somewhere. But such a tool might put a lot of people on l-k out of job @)
>
> heh. we could do some basic stuff at least. run through lindent, and see
> if it changes ;-)

Good luck weeding out the false positives from that.

> Can't tell whether that was meant to be positive or negative feedback.
> All this would require is "email patch to test-thingy@test.kernel.org".

I meant it would be better if it happened automatically when the patch
is submitted through the normal channels.

-Andi
