Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbTGLPgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTGLPgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:36:49 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:1723 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266071AbTGLPgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:36:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sun, 13 Jul 2003 01:53:43 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307112053.55880.kernel@kolivas.org> <20030712154924.GC15452@holomorphy.com>
In-Reply-To: <20030712154924.GC15452@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307130153.43184.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 01:49, William Lee Irwin III wrote:
> On Fri, Jul 11, 2003 at 08:53:38PM +1000, Con Kolivas wrote:
> > Wli coined the term "isochronous" (greek for same time) for a real time
> > task that was limited in it's timeslice but still guaranteed to run. I've
> > decided to abuse this term and use it to name this new policy in this
> > patch. This is neither real time, nor guaranteed.
>
> I didn't coin it; I know of it from elsewhere.

s/coined/informed me of

Con

