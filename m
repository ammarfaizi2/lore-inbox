Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTEPQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTEPQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:58:18 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:24003 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264503AbTEPQ6R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:58:17 -0400
Date: Fri, 16 May 2003 19:11:08 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: ide-floppy and 2.5.69: not so good...
Message-ID: <20030516171108.GB24088@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my ZIP 250 was slave on my computer, I removed the master and put it as
master, and I get:

May 16 19:09:23 localhost kernel: hda: DMA interrupt recovery
May 16 19:09:23 localhost kernel: hda: lost interrupt
May 16 19:10:13 localhost kernel: hda: DMA interrupt recovery
May 16 19:10:13 localhost kernel: hda: lost interrupt

Why?

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
