Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTFYUkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFYUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:40:34 -0400
Received: from zephir.uk.clara.net ([195.8.69.53]:25354 "EHLO
	zephir.uk.clara.net") by vger.kernel.org with ESMTP id S265073AbTFYUk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:40:27 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Date: Wed, 25 Jun 2003 21:54:36 +0100
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
X-no-productlinks: yes
X-Comment-To: Thijs
References: <fa.cf4gkbu.1h1o5ik@ifi.uio.no> <fa.hh6ttrp.1d52bhj@ifi.uio.no>
Subject: Re: Linux 2.4.21-ac3
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-15
NNTP-Posting-Host: daria.co.uk
Message-ID: <58b.3efa0c0c.ad9fb@trespassersw.daria.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.hh6ttrp.1d52bhj@ifi.uio.no>,
	Thijs <thijs@balpol.tudelft.nl> writes:
T> Hi,
T> 
T> Since 2.4.21-ac2 i'm experiencing problems with Postfix on Debian 
T> Stable. Messages get corrupted while being handled by Postfix.
T> 
T> Vanilla 2.4.21 and 2.4.21-ac1 are fine, but 2.4.21-ac2/3 causes 
T> problems. Going back to ac1 resolves the issue. I tried kernels on 
T> several Debian servers, but all have the same problem. Could be it's 
T> something in postfix that emerges with this specific patch, but it's at 
T> least curious. I'm not too familiar with this matter unfortunately.

Same problem here observed with -ac3 (reiserfs). 

Thanks for the warning.
