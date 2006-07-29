Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWG2IDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWG2IDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWG2IDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:03:31 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:5333 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932642AbWG2IDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:03:30 -0400
Date: Sat, 29 Jul 2006 09:59:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Handle X <xhandle@gmail.com>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
In-Reply-To: <200607282143.58915.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.61.0607290958590.20234@yvahk01.tjqt.qr>
References: <20060727205911.GB5356@martell.zuzino.mipt.ru>
 <6de39a910607280934t5c264b20w38c1f52c978b4e15@mail.gmail.com>
 <20060728164839.GA20974@filer.fsl.cs.sunysb.edu> <200607282143.58915.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > >>       0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
>> > >>
>> > >> I'd say #2 really sucks.
>> > >
>> > >IMHO #3 sucks more, it's not as easy to spot when glossing over the
>> > >code, the underscores make it quite ugly (think _r________) and it's
>> 
>> Even better!
>
>So now tell me how is S_I0644 better than 0644? S_IRUGO et al at least hide
>implementation details.

+1. 


Jan Engelhardt
-- 
