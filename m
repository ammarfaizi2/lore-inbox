Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUJPKBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUJPKBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 06:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUJPKBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 06:01:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:51625 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268279AbUJPKBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 06:01:45 -0400
Date: Sat, 16 Oct 2004 12:01:26 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Danny <dannydaemonic@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: profile path bug again (was Re: mm kernel oops with r8169 & named, PREEMPT)
Message-ID: <20041016100125.GA15833@electric-eye.fr.zoreil.com>
References: <9625752b041013091772e26739@mail.gmail.com> <9625752b04101309182a96fbd2@mail.gmail.com> <200410131129.05657.jdmason@us.ltcfwd.linux.ibm.com> <20041013181840.GA30852@electric-eye.fr.zoreil.com> <9625752b04101313417be4cf90@mail.gmail.com> <20041013205433.GC30761@electric-eye.fr.zoreil.com> <9625752b04101314595f72f84a@mail.gmail.com> <9625752b04101415043a078b93@mail.gmail.com> <20041015161818.GA2577@electric-eye.fr.zoreil.com> <9625752b04101514073f6dab24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9625752b04101514073f6dab24@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny <dannydaemonic@gmail.com> :
[profile path bug hits hard]
> Also posting the oops directly instead of linking to it probably
> allows people passing by to look at the oops, increasing the total
> number of eyes.

Yes.

Oops posting is still on-topic in l-k.

> I have a quick question though, if I'm using the kernel with all the
> debug features turned on, should I still run it through ksymoops?

Your file named "oops-raw" contained the relevant information.

--
Ueimor
