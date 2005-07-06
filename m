Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVGFCgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVGFCgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVGFCeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:34:15 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55960 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262053AbVGFCTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:19 -0400
Subject: [0/48] Suspend2 2.1.9.8 for 2.6.12
In-Reply-To: <nigel@suspend2.net>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164393426@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As requested, here are the patches that form Suspend2, for review.

I've tried to split it up into byte size chunks, but please don't expect
that these will be patches that can mutate swsusp into Suspend2. That
would roughly equivalent to asking for patches that patch Reiser3 into
Reiser4 - it's a redesign.

There are a few extra patches not included here, all of which are not
core to Suspend2. Since I'm not expecting this code to get merged as is,
I haven't worried about including them. If that's a problem, let me know.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

