Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUB0GRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUB0GRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:17:14 -0500
Received: from cache1.telkomsel.co.id ([202.155.14.251]:8202 "EHLO
	cache1.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S261172AbUB0GRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:17:12 -0500
Subject: Radeon Framebuffer Driver in 2.6.3?
From: arief# <arief_m_utama@telkomsel.co.id>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077863238.2522.6.camel@damai.telkomsel.co.id>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 13:27:18 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,


Before, please cc me the answer, as I'm not on the list right now.

In 2.6.3 (including -mmX patches), radeon framebuffer seems to having
problems. Everytime I do clear screen, it only 'half cleared'. I still
can see the mark of the previous texts in shaded mode. And it does not
do deletion well, too. 

Anybody else having the same problem?

I like to see what's the problem, but I don't know framebuffer code (or
any kernel code at all) well. If someone could give me pointer, I could
give it a shot. 

My hardware is, IBM Thinkpad T30 with Radeon 7500 card.
2.6.2 and 2.4 does not have this problem. 


Regards.
-arief

