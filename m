Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRCGDQM>; Tue, 6 Mar 2001 22:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbRCGDQC>; Tue, 6 Mar 2001 22:16:02 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:32129
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S129915AbRCGDP5>; Tue, 6 Mar 2001 22:15:57 -0500
Date: Tue, 6 Mar 2001 19:13:56 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200103070313.f273Dut01801@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: relson@osagesoftware.com, Thiago Rondon <maluco@mileniumnet.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 - do_try_to_free_pages failed
In-Reply-To: <4.3.2.7.2.20010306214749.00cdd880@mail.osagesoftware.com>
In-Reply-To: <4.3.2.7.2.20010306185522.00c54dd0@mail.osagesoftware.com> <4.3.2.7.2.20010306214749.00cdd880@mail.osagesoftware.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I know that 2.2.19 is still in the -pre state.  [ . . . ]  Have
> significant VM problems been fixed?

Yes, 2.2.19-pre incorporates what was known as Andrea's VM-global
patch, and it is widely reported to fix the exact problem you
mentioned.

Wayne
