Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTD1Xsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTD1Xsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:48:53 -0400
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:20871 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S261251AbTD1Xsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:48:52 -0400
From: Michiel Borkent <borkdude@cs.utwente.nl>
Reply-To: borkdude@cs.utwente.nl
To: linux-kernel@vger.kernel.org, andrewm@uow.edu.au, netdev@oss.sgi.com
Subject: 3c59x support
Date: Tue, 29 Apr 2003 02:02:02 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304290202.02811.borkdude@cs.utwente.nl>
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am trying to make a 2.4.20 kernel with 3c59x support.
My card is a:

3Com 3c900 Cyclone 10Mbps TPO 

card and it only works with the 3c59x-scyld module, I found with Debian Woody 
with a linux v2.2 kernel.

It does NOT work with the normal 3c59x module and as I am trying to make a 
2.4.20 kernel, it still doesn't work. I chose support for "Vortex/Boomerang" 
and normally my card would be supported I think.

Can someone help me with this?

Greetings,
Michiel Borkent
