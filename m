Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTDPO16 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTDPO16 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:27:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49061 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264376AbTDPO16 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:27:58 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 16 Apr 2003 16:39:50 +0200 (MEST)
Message-Id: <UTC200304161439.h3GEdoM21920.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torden88@yahoo.no
Subject: Re: [Bug 588] New: 2.5.67 won't get the real partition table for hdb
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do I have to upgrade my modutils?

Not for this patch. But 2.5 requires new modutils.
Try something below
    http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

See also http://www.win.tue.nl/~aeb/linux/lk/lk-2.html#ss2.5.1

Andries
