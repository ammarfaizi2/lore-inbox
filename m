Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbRLSTjm>; Wed, 19 Dec 2001 14:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285426AbRLSTjb>; Wed, 19 Dec 2001 14:39:31 -0500
Received: from inway106.cdi.cz ([213.151.81.106]:64998 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S285424AbRLSTjT>;
	Wed, 19 Dec 2001 14:39:19 -0500
Date: Wed, 19 Dec 2001 20:39:13 +0100 (CET)
From: Martin Devera <devik@cdi.cz>
To: Chris Meadors <clubneon@hereintown.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
In-Reply-To: <Pine.LNX.4.40.0112191448200.5242-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is interesting that 2.2 can be done with -O. Also I'd expect
errors during compilation and not silent crash...
devik

> The kernel relies on features turned on by -O2 and will not function
> properly with just -O of any version of gcc.

