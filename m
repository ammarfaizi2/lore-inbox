Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTGLPdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbTGLPdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:33:22 -0400
Received: from holomorphy.com ([66.224.33.161]:47039 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266025AbTGLPdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:33:21 -0400
Date: Sat, 12 Jul 2003 08:49:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Phillips <phillips@arcor.de>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Message-ID: <20030712154924.GC15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@arcor.de>
References: <200307112053.55880.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307112053.55880.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 08:53:38PM +1000, Con Kolivas wrote:
> Wli coined the term "isochronous" (greek for same time) for a real time task 
> that was limited in it's timeslice but still guaranteed to run. I've decided 
> to abuse this term and use it to name this new policy in this patch. This is 
> neither real time, nor guaranteed.

I didn't coin it; I know of it from elsewhere.


-- wli
