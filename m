Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbTIIQKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbTIIQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:10:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14798 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263939AbTIIQKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:10:33 -0400
Subject: Determining pci bus from irq
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 09 Sep 2003 09:10:31 -0700
Message-Id: <1063123832.2037.40.camel@dyn318261bld.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a nice way to determine, given an irq number, the pci bus
number that raised the interrupt?



