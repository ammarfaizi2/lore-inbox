Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTLAO1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLAO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:27:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:17642 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263765AbTLAO1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:27:46 -0500
Date: Mon, 1 Dec 2003 12:25:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4 future 
Message-ID: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The intention of this email is to clarify my position on 2.4.x future.

2.6 is becoming more stable each day, and we will hopefully see a 2.6.0
release during this month or January.

Having that mentioned, I pretend to:

- Fix pending problems which might required more intrusive modifications
during 2.4.24. New drivers will be accept during this period (for example,
Cyclades PC300 driver, input userlevel driver support, or other sane
driver which might come up).

- From 2.4.25 on, fix only critical/security problems.



