Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUCJWyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUCJWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:54:04 -0500
Received: from hera.kernel.org ([63.209.29.2]:38300 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262876AbUCJWwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:52:08 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: pts/X counts on
Date: Wed, 10 Mar 2004 22:51:59 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2o66f$44a$1@terminus.zytor.com>
References: <20040310190902.GA2226@atoom.net> <20040310192415.GL655@holomorphy.com> <20040310193340.GB2278@atoom.net> <20040310193554.GM655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078959119 4235 63.209.29.3 (10 Mar 2004 22:51:59 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 10 Mar 2004 22:51:59 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040310193554.GM655@holomorphy.com>
By author:    William Lee Irwin III <wli@holomorphy.com>
In newsgroup: linux.dev.kernel
>
> [On 10 Mar, @20:24, William wrote in "Re: pts/X counts on ..."]
> >> This change in behavior was intentional. It should not affect your
> >> applications. The change was part of a patch that made pty's
> >> completely dynamic.
> 
> On Wed, Mar 10, 2004 at 08:33:40PM +0100, Miek Gieben wrote:
> > ah, it's a feature :-) But I'm not seeing it on all my systems....(running
> > 2.6.3)
> > Thanks,
> > grtz Miek
> 
> Odd. Maybe it's -mm vs. non -mm.
> 

It is.

	-hpa
