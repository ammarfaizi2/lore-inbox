Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVK3PyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVK3PyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVK3PyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:54:11 -0500
Received: from krl.krl.com ([192.147.32.3]:50092 "EHLO krl.krl.com")
	by vger.kernel.org with ESMTP id S1751421AbVK3PyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:54:09 -0500
Date: Wed, 30 Nov 2005 10:53:28 -0500
Message-Id: <200511301553.jAUFrSQx026450@p-chan.krl.com>
From: Don Koch <aardvark@krl.com>
To: Michael Krufky <mkrufky@m1k.net>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Subject: Re: Gene's pcHDTV 3000 analog problem
In-Reply-To: <438D38B3.2050306@m1k.net>
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
	<c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
	<438CFFAD.7070803@m1k.net>
	<200511300007.56004.gene.heskett@verizon.net>
	<438D38B3.2050306@m1k.net>
Organization: KRL
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005 00:29:23 -0500
Michael Krufky wrote:

> Gene Heskett wrote:
> 
> >On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
> >
> >[...]
> >
> >>ll I can think of doing next is to have Gene, Don or Perry do a
> >>bisection test on our cvs repo.... checking out different cvs revisions
> >>until we can narrow it down to the day the problem patch was applied.
> >>

Do we know of a date where the code is known to work.  First thing I'd like to
do is verify that the card works at all.  Remember, I've never seen NTSC tuner
mode work and don't want to chase a red herring if the card is busted.

Thanks,
-d
