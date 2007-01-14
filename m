Return-Path: <linux-kernel-owner+w=401wt.eu-S1751061AbXANBDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXANBDE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXANBCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:02:37 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41557 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXANBC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:02:29 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 14 Jan 2007 02:02:20 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.af9f8565dea59963@s5r6.in-berlin.de>
Message-ID: <tkrat.29ccd2bff98a0874@s5r6.in-berlin.de>
References: <45A9092F.7060503@student.ltu.se>
 <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se>
 <tkrat.343d5eb8f1097532@s5r6.in-berlin.de> <45A96C3F.3090307@student.ltu.se>
 <tkrat.af9f8565dea59963@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> gcc -o test3.o test.c test.c
                           ^^ typo
gcc -o test3.o test.c test2.c
-- 
Stefan Richter
-=====-=-=== ---= -===-
http://arcgraph.de/sr/

