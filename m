Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUA1PFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUA1PFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:05:33 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:54665 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265984AbUA1PE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:04:58 -0500
Subject: Re: Linux 2.4.25-pre6
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Lukasz Trabinski <lukasz@trabinski.net>, linux-kernel@vger.kernel.org,
       riel@redhat.com
In-Reply-To: <Pine.LNX.4.58L.0401211809220.5874@logos.cnet>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet>
	 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet>
	 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
	 <1074686081.16045.141.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet>
Content-Type: text/plain
Message-Id: <1075302289.1633.158.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 28 Jan 2004 15:04:49 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 18:12 -0200, Marcelo Tosatti wrote:
> Lets try the clueless approach and remove the inode reclaim highmem fixes
> from Rik.
> 
> Please revert the attached patch (againts -pre6).

Did this make a difference?

-- 
dwmw2

