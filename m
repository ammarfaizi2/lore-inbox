Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSA1Xcy>; Mon, 28 Jan 2002 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSA1Xcp>; Mon, 28 Jan 2002 18:32:45 -0500
Received: from www.transvirtual.com ([206.14.214.140]:40197 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287676AbSA1Xcg>; Mon, 28 Jan 2002 18:32:36 -0500
Date: Mon, 28 Jan 2002 15:32:28 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andreas Happe <andreashappe@subdimension.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.2-dj 5 & 6 - compile error using radeon fb
In-Reply-To: <000d01c1a83d$602df2e0$094b2e3e@angband>
Message-ID: <Pine.LNX.4.10.10201281531530.14010-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i've got problems compiling the kernel 2.5.2-dj5 and dj6 due to a syntax
> error in ./drivers/video/radeonfb.c . After hours spent in solitude and
> asceticism i was able to trace back the error to a missing semicolon at line
> 1454. Could anyone fix it (adding a single character is a huge amount of
> work, i know, but somebody got to do it)

Their where actly a few more errors than that. I sent in a patch already
:-)

