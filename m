Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTLNTsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTLNTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 14:48:53 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:45162 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262324AbTLNTsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 14:48:53 -0500
From: Guillaume Foliard <guifo@wanadoo.fr>
Organization: _^_
To: linux-kernel@vger.kernel.org
Subject: Scheduler degradation since 2.5.66
Date: Sun, 14 Dec 2003 20:48:51 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312142048.51579.guifo@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been playing with kernel 2.5/2.6 for around 6 months now. I was quite 
pleased with 2.5.65 to see that the soft real-time behaviour was much better 
than 2.4.x. Since then I tried most of the 2.5/2.6 versions. But recently 
someone warned me about some degradations with 2.6.0-test6. To show the 
degradation since 2.5.66 I have run a simple test program on most of the 
versions. This simple program is measuring the time it takes to a process to 
be woken up after a call to nanosleep.
As the results are plots, please visit this small website for more 
information : http://perso.wanadoo.fr/kayakgabon/linux
I'm ready to perform more tests or provide more information if necessary.

Guillaume
