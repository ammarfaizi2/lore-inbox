Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWHBHKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWHBHKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWHBHKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:10:03 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:10636 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751295AbWHBHKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:10:01 -0400
Date: Wed, 2 Aug 2006 09:08:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
In-Reply-To: <20060801230003.GB14863@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0608020906120.7593@yvahk01.tjqt.qr>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain>
 <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com>
 <20060801230003.GB14863@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> +			++bad_count;
>
>How about post increment?
>

There would no difference, in effect.
Same goes for the return; mentioned elsewhere in the thread.


Jan Engelhardt
-- 
