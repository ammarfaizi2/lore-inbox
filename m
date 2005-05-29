Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVE2Xn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVE2Xn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVE2Xn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:43:57 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:57518 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261416AbVE2Xn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:43:56 -0400
Subject: IMPI doesn't build as modules with 2.6.12-rc5.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117410309.12243.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 30 May 2005 09:45:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I get a build failure making modules in 2.6.12-rc5. It occurs in
drivers/char/ipmi/impi_devintf.c, and is related to recent changes to
class_simple_*.

Regards,

Nigel

