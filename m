Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUFDNeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUFDNeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUFDNeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:34:14 -0400
Received: from babylon5.hosteurope.de ([217.115.143.98]:29381 "EHLO
	babylon5.hosteurope.de") by vger.kernel.org with ESMTP
	id S265777AbUFDNeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:34:09 -0400
Message-ID: <58992.134.2.12.41.1086356047.30896.squirrel@webmailer.hosteurope.de>
Date: Fri, 4 Jun 2004 15:34:07 +0200 (CEST)
Subject: default minimum MTU 552?
From: "Uwe E. Bilger" <uwelists@u-b.de>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was looking for some more information about the minimum MTU setting of
552 for path MTU discovery, but couldn't find anything why it is exactly
552, and not, like one would expect, 576, aside of the fact that the ppp
example configs mysteriously suggest also an MTU of 552...

So, why 552? And is there a standard?

Regards,

Uwe


