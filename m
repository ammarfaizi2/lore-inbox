Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTFRAc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFRAc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:32:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54777 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265024AbTFRAc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:32:57 -0400
Subject: [patch] updated preemptive kernel for 2.4.21
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1055897210.7069.1835.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 17 Jun 2003 17:46:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put an updated preempt-kernel patch up at:

http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

The patch is a rediff to 2.4.21, but also contains a number of fixes for
preempt-unsafe code -- both longstanding issues and new problems arising
from the 2.4.21 development cycle. Thanks to Joe Korty and various folks
at MontaVista for a lot of the fixes.

Please give it a whirl. Or, even better, switch to 2.5

Enjoy,

	Robert Love


