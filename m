Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSICUAq>; Tue, 3 Sep 2002 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSICUAq>; Tue, 3 Sep 2002 16:00:46 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:35201 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318894AbSICUAp>; Tue, 3 Sep 2002 16:00:45 -0400
Date: Tue, 3 Sep 2002 14:05:10 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Benjamin LaHaise <bcrl@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Pavel Machek <pavel@suse.cz>, Peter Chubb <peter@chubb.wattle.id.au>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <E17mJsl-0005k6-00@starship>
Message-ID: <Pine.LNX.4.44.0209031404500.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Daniel Phillips wrote:
> If you must have a clever macro:
> 
>    #define lli(foo) (long long int) (foo)
>    #define llu(foo) (long long unsigned) (foo)

Type safety not given.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

