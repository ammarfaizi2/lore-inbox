Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTHVWkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTHVWki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:40:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:36868 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261683AbTHVWkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:40:35 -0400
Subject: Re: [PATCH]O18int
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308222231.25059.kernel@kolivas.org>
References: <200308222231.25059.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1061592027.13091.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 00:40:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 14:31, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here is a small patchlet.
> 
> It is possible tasks were getting more sleep_avg credit on requeuing than they 
> could burn off while running so I've removed the on runqueue bonus to 
> requeuing task. 

I have been using 2.6.0-test3-mm3 plus O18int for a whole day and I must
say that, for me, O18int is the best I've seen until date. I dare to say
I think it's even better than O10int.

