Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267750AbUBRSRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUBRSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:17:45 -0500
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:31687 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S267750AbUBRSRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:17:43 -0500
Subject: Re: Intel vs AMD x86-64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040218153123.2fa8ab42.diegocg@teleline.es>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
	 <16435.14044.182718.134404@alkaid.it.uu.se>
	 <20040218153123.2fa8ab42.diegocg@teleline.es>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077128253.12208.5.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 10:17:34 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 06:31, Diego Calleja García wrote:

> Does that mean that the opteron-based distros will be able to run 
> their x86-64 kernelspace/userspace in intel micros without modifications,
> or only the userspace?

Presumably there will be some minor kernel modifications needed, but
Intel's public position is that going forward, there's only one 64-bit
kernel and userspace needed for both platforms.

	<b

