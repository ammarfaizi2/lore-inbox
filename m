Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSJ1HlL>; Mon, 28 Oct 2002 02:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJ1HlL>; Mon, 28 Oct 2002 02:41:11 -0500
Received: from tapu.f00f.org ([66.60.186.129]:49117 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262981AbSJ1HlK>;
	Mon, 28 Oct 2002 02:41:10 -0500
Date: Sun, 27 Oct 2002 23:47:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021028074730.GA22228@tapu.f00f.org>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk> <ap97nr$h6e$1@forge.intermeta.de> <1035479086.9935.6.camel@gby.benyossef.com> <1035539042.23977.24.camel@forge> <apcaub$ov5$1@cesium.transmeta.com> <apdrkh$h8n$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdrkh$h8n$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 10:43:29AM +0000, Henning P. Schmiedehausen
wrote:

> But my point is, that these beasts normally don't run a general
> purpose operating system and that they're much less prone to buffer
> overflow or similar attacks, simply because they don't use popular
> software with known bugs (e.g.  OpenSSL) or these functions (like
> doing crypto) are in hardware.

As someone who has worked on a couple of these which are presently on
the market I can assure you that many of these things have plenty of
'popular software' in them... albeit hacked up and mangled to bits at
times... but it's there, and often vulnerable to many of the same
problems you would have under Linux/Apache/whatever.


  --cw

