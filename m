Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWETLYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWETLYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 07:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWETLYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 07:24:09 -0400
Received: from [212.76.93.214] ([212.76.93.214]:44036 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932313AbWETLYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 07:24:08 -0400
From: Al Boldi <a1426z@gawab.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: replacing X Window System !
Date: Sat, 20 May 2006 14:19:55 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200605200733.08757.a1426z@gawab.com> <20060520102526.GH10077@stusta.de>
In-Reply-To: <20060520102526.GH10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605201419.55428.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, May 20, 2006 at 07:33:08AM +0300, Al Boldi wrote:
> > Not that I would agree with the in-Kernel X idea per se, but it does
> > raise the issue of a stable API once more, as it would allow more
> > freedom to create a module against a version line w/o fear of being
> > rejected.
>
> It does not raise the issue of a stable kernel API:
>
> The solution is to work on getting the module included into the kernel.
> All problems with changing kernel APIs vanish as soon as your module is
> included. This is independent from what the module in question is doing.

Yes, but the question is:
	What's the trick to get the module into the kernel?

It seems that we are currently under the mercy of the few, who have the power 
to control this.  And forking isn't really a solution.

With a stable API, I can just implement whatever w/o caring whether it is 
included into the kernel.  Now that's freedom!

Thanks!

--
Al

