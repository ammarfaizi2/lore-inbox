Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271621AbRHZX31>; Sun, 26 Aug 2001 19:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271626AbRHZX3R>; Sun, 26 Aug 2001 19:29:17 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:42503 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271621AbRHZX3E>; Sun, 26 Aug 2001 19:29:04 -0400
Subject: Re: [PATCH] Updated: Let net devices contribute entropy
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <998616119.9306.32.camel@phantasy>
In-Reply-To: <998616119.9306.32.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 26 Aug 2001 19:29:15 -0400
Message-Id: <998868579.783.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated patch for 2.4.8-ac12 is available at:
http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-netdev-random-1
and
http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-netdev-random-2
as always, #1 adds the core support and #2 updates all network devices
to use the new flag.

2.4.9 patches are still available from the same place.

nothing new, sans the resync, since the previous patch.  i believe all
architectures and network devices are still supported.

the interested are highly encouraged to read the previous thread for a
summary of the patch and the resulting discussions.
 
-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

