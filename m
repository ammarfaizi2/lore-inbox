Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTLJOc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTLJOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:32:28 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:5643 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S263466AbTLJOc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:32:26 -0500
Date: Wed, 10 Dec 2003 15:32:22 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.23: pc_keyb.c] request_irq() without free_irq().
Message-ID: <Pine.LNX.4.33.0312101527510.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Looks like the the counterpart for kbd_request_irq() is missing. Am I
right?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

