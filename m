Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWEYUey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWEYUey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWEYUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:34:54 -0400
Received: from hera.kernel.org ([140.211.167.34]:51914 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030400AbWEYUex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 16:34:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Date: Thu, 25 May 2006 13:34:22 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e554ce$q23$1@terminus.zytor.com>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <20060525201347.GA21926@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148589262 26692 127.0.0.1 (25 May 2006 20:34:22 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 25 May 2006 20:34:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060525201347.GA21926@csclub.uwaterloo.ca>
By author:    lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
In newsgroup: linux.dev.kernel
> 
> And Debian too.  I thought it was invalid to put the FQDN as your
> hostname.  Also makes updating the domain for a network harder (if one
> would ever want to do so).  Putting the FQDN as my hostname, makes
> hostname -f act very strange.  I think a number of tools think doing it
> is wrong.
> 

BSD practice has been to do it; SysV practice has been to not do it.
This probably has to do with the fact that a larger percentage of BSD
systems were connected to the Internet earlier on, being popular at
universities.

	-hpa

