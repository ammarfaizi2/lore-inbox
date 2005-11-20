Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVKTWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVKTWKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVKTWKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:10:05 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41953 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932101AbVKTWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:10:02 -0500
Subject: Re: 2.6.14.2: repeated oops in i810 init
From: Lee Revell <rlrevell@joe-job.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4380EB33.2060305@eyal.emu.id.au>
References: <4380EB33.2060305@eyal.emu.id.au>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 17:08:45 -0500
Message-Id: <1132524526.22663.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 08:31 +1100, Eyal Lebedinsky wrote:
> I had this happen to me about three times, I captured it twice
> using serial console [see logs at the bottom].

Why would you use the old OSS driver?  It's scheduled to be removed from
the kernel anyway.  What's wrong with the ALSA driver?

Lee

