Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272619AbTHFVZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272622AbTHFVZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:25:23 -0400
Received: from fepC.post.tele.dk ([195.41.46.147]:44252 "EHLO
	fepC.post.tele.dk") by vger.kernel.org with ESMTP id S272619AbTHFVZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:25:17 -0400
From: Henrik Raeder Clausen <henrik@fangorn.dk>
To: linux-kernel@vger.kernel.org
Subject: ieee1394 (Firewire) driver problem
Date: Wed, 6 Aug 2003 23:25:15 +0200
User-Agent: KMail/1.5
References: <3F306858.1040202@mrs.umn.edu> <20030806180427.GC21290@matchmail.com> <20030806141905.40126313.akpm@osdl.org>
In-Reply-To: <20030806141905.40126313.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308062325.15502.henrik@fangorn.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi

   This is my first post here, bear with me if I'm not providing enough 
detail.

   I have found what seems to be a problem with the ieee1394 (Firewire) driver 
in 2.6.0-test2. The driver works (for me) only if compiled as a module, not 
compiled statically into the kernel. When compiled statically, it aborts 
loading complaining that it cannot find the module. This module is of course 
not around, since the driver is compiled in.

   The problem has been there since I started toying around with 2.5.3X. 

    My computer is a generic Athlon XP 1800+, with a very generic (read: 
cheapo) Firewire controller. 


   Have fun!

	Henrik Ræder Clausen
	Copenhagen
