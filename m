Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTEVORt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEVORt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:17:49 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:43927 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261878AbTEVORt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:17:49 -0400
To: <linux-kernel@vger.kernel.org>
Subject: EPIC100 problems with RH9 gcc 3.2.2-5 and not with RH8.0 3.2-7?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 22 May 2003 16:31:07 +0200
Message-ID: <m3ptmbuk7o.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having problems with epic100 module. The kernel is 2.4.21rc2, SMP.

epic100 module from 2.4.21rc2 kernel, compiled with RH9 "gcc 3.2.2-5"
produces ca 1% of RX frame errors.

epic100 module from 2.4.20rc2 (insmod -f into 2.4.21rc2 kernel) produces
these errors, too.

The same source (2.4.20rc2) compiled with "RH8.0 gcc 3.2-7 20020903" works
fine with insmod -f (and with 2.4.20rc2 SMP kernel as well).

Any idea what's wrong?
I'm working on it, but someone might have fixed it already.
-- 
Krzysztof Halasa
Network Administrator
