Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTFQVjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:39:16 -0400
Received: from ip68-14-69-43.ri.ri.cox.net ([68.14.69.43]:48768 "EHLO neutrino")
	by vger.kernel.org with ESMTP id S264935AbTFQVjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:39:08 -0400
Subject: airo_cs load error
From: Matthew Koch <MatthewK@hsius.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Helicopter Support, Inc.
Message-Id: <1055883160.499.5.camel@neutrino>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 16:52:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a cisco aironet 350 series on 2.5.72.  When attempting to
load the module, I get the following messages:

airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: register interrupt 0 failed, rc -16
airo_cs: RequestConfiguration: Operation succeeded

All pcmcia drivers are loaded, I've tried both compiled in and as
modules.  The same card works with no problems on 2.4.[18-21].  Google
only shows one match with no resolution to the problem.  Any ideas?
