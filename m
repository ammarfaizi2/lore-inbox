Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGRA7Y>; Wed, 17 Jul 2002 20:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGRA7Y>; Wed, 17 Jul 2002 20:59:24 -0400
Received: from dsl-213-023-043-041.arcor-ip.net ([213.23.43.41]:47297 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316792AbSGRA7Y>;
	Wed, 17 Jul 2002 20:59:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: daw@mozart.cs.berkeley.edu (David Wagner), linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Date: Thu, 18 Jul 2002 03:03:45 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020709201703.GC27999@kroah.com> <3D2AF6EA.1030008@us.ibm.com> <ah527n$brv$1@abraham.cs.berkeley.edu>
In-Reply-To: <ah527n$brv$1@abraham.cs.berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Uzhq-0004gf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 02:30, David Wagner wrote:
> Dave Hansen  wrote:
> >The Stanford Checker or something resembling it would be invaluable 
> >here.  It would be a hell of a lot better than my litle patch!
> 
> Hmm.  There's a chance we might be able to help.  Our group is building
> a tool called MOPS that is similar in spirit to the Stanford Checker.
> MOPS is work-in-progress and will be open source.  I haven't tried it
> yet on the Linux kernel, but this seems like a reasonable thing to try.

Excellent, there is an ecological niche ready and waiting for the first
group to do what the Stanford group has done, but open the source.  It's
beyond me why the Stanford group hasn't done so, perhaps it has something
to do with university politics.

-- 
Daniel
