Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTJCTfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTJCTfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 15:35:05 -0400
Received: from 176.Red-81-38-200.pooles.rima-tde.net ([81.38.200.176]:19522
	"EHLO falafell") by vger.kernel.org with ESMTP id S263839AbTJCTe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 15:34:58 -0400
Date: Fri, 3 Oct 2003 21:34:13 +0200
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20031003193413.GA1371@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au> <3F7863F0.6070401@wmich.edu> <20031002004102.GB2013@81.38.200.176> <3F7B9600.408@cyberone.com.au> <20031002190744.GC1215@81.38.200.176> <3F7CBDD4.7010503@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7CBDD4.7010503@cyberone.com.au>
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 10:07:48AM +1000, Nick Piggin wrote:
> 
> Have a look at my scheduler if you like. It won't estimate interactivity
> but it works quite well if you nice -10 your X server. Ie. explicitly
> state which process should be favoured.
> http://www.kerneltrap.org/~npiggin/v15a/
> 

I will.

Have you made available any tools you used to debug the scheduler? I think
it would be useful to characterize last time the process got a chance to
run to measure the timeslices and the quantums that are being given.

Regards.
-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
