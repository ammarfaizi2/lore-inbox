Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWGYSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGYSmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWGYSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:42:32 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:29964 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750842AbWGYSmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:42:31 -0400
Date: Tue, 25 Jul 2006 20:42:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: David Lang <dlang@digitalinsight.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Message-Id: <20060725204236.2afae33d.khali@linux-fr.org>
In-Reply-To: <44C64FC1.4060501@linuxtv.org>
References: <20060725034247.GA5837@kroah.com>
	<m33bcqdn5y.fsf@anduin.mandriva.com>
	<200607251123.40549.adq_dvb@lidskialf.net>
	<Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz>
	<1153846619.8932.36.camel@laptopd505.fenrus.org>
	<44C64FC1.4060501@linuxtv.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> The fix can be found here... We'll need this queued up for 2.6.17.8 ...
>  I have already attached this inline in a prior email, not sure how many
> people have seen that yet...
> 
> You can also get it from here:
> 
> http://linuxtv.org/~mkrufky/stable/2.6.17.y/budget-av-compile-fix.patch

Yes, it fixed the compilation cleanly for me (on both i386 and x86_64).
I can't test beyond that though, as I don't have that specific hardware.

Thanks,
-- 
Jean Delvare
