Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTLROjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTLROju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:39:50 -0500
Received: from crete.csd.uch.gr ([147.52.16.2]:41438 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S265208AbTLROjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:39:49 -0500
Organization: 
Date: Thu, 18 Dec 2003 16:38:26 +0200 (EET)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: Logitech USB Internet Navigator keyboard
Message-ID: <Pine.GSO.4.58.0312181630410.3714@oneiro.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.0 I can't type '\' in text mode. If I press this key and I
am in text mode what happens is that I change console, as if I had pressed
Alt+Fn. But in X it works just fine.

I have also tested 2.6.0-test11-mm1, where I get the same behaviour in
text mode. But in this kernel it doesn't work also in X, where pressing
'\' prints nothing on my screen.

The keyboard is a Logitech USB Internet Navigator Keyboard, connected
through USB.

Regards

	Panagiotis Papadakos
