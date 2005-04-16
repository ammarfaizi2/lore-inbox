Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVDPBEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVDPBEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVDPBEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:04:54 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:15118 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262491AbVDPBEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:04:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 01:02:53 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3po7t$vrn$1@abraham.cs.berkeley.edu>
References: <20050413234337.GE12263@certainkey.com> <20050414000939.GH3174@waste.org> <20050414002647.GG12263@certainkey.com> <20050414004435.GJ3174@waste.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113613374 32631 128.32.168.222 (16 Apr 2005 01:02:53 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 01:02:53 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall  wrote:
>While it may have some good properties, it lacks
>some that random.c has, particularly robustness in the face of failure
>of crypto primitives.

It's probably not a big deal, because I'm not worried about the
failure of standard crypto primitives, but--

Do you know of any analysis to back up the claim that /dev/random
will be robust in the failure of crypto primitives?  I have never
seen anyone try to do such an analysis, but maybe you know of something
that I don't.
