Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCCAtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCCAtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCCApj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:45:39 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:2259 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261335AbVCCAnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:43:25 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.6.11: iostat values broken, or IDE siimage driver ? 
Date: Thu, 3 Mar 2005 00:43:24 +0000 (UTC)
Organization: Cistron
Message-ID: <d05mjc$v0u$1@news.cistron.nl>
References: <d05513$8fr$1@news.cistron.nl> <200503022202.j22M2KUK020376@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1109810604 31774 194.109.0.112 (3 Mar 2005 00:43:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200503022202.j22M2KUK020376@owlet.beaverton.ibm.com>,
Rick Lindsley  <ricklind@us.ibm.com> wrote:
>Mike -- where did you get your iostat from?  There's a couple of different
>flavors out there and it may not make a difference but just in case ...

Debian, sysstat+5.0.6-4

I know about the iostat problems - there were 32/64 bit issues,
etc - but those have been solved in this version. Also the exact
same iostat works fine on 2.6.10 and 2.6.11-rc3 kernels.

Mike.

