Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318938AbSHSQe4>; Mon, 19 Aug 2002 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318939AbSHSQe4>; Mon, 19 Aug 2002 12:34:56 -0400
Received: from smtp03.web.de ([217.72.192.158]:44567 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318938AbSHSQez>;
	Mon, 19 Aug 2002 12:34:55 -0400
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.20pre3 breaks alsa 0.9.0.rc3
References: <200208191609.MAA27419@bromo.msbb.uc.edu>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Mon, 19 Aug 2002 18:37:22 +0200
In-Reply-To: <200208191609.MAA27419@bromo.msbb.uc.edu> (Jack Howarth's
 message of "Mon, 19 Aug 2002 12:09:28 -0400 (EDT)")
Message-ID: <87y9b2st31.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack!

* Jack Howarth writes:
>I haven't seen this mentioned yet but the new pre3 changes remove the
>typedef of urb_t and purb_t from include/linux/usb.h. This causes
>alas-drivers 0.9.0rc3 to fail to compile. I wanted to find out if this
>removal of urb_t and purb_t was final or if it would be regressed back
>in pre4?  Thanks for any information.

alsa CVS was updated today to compile with 2.4.19-pre3, so I guess it
will be permanent.

regards
Markus

