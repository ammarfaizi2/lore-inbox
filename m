Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVD2Mww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVD2Mww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 08:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVD2Mwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 08:52:51 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:39873 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262537AbVD2Mwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 08:52:50 -0400
Date: Fri, 29 Apr 2005 14:52:48 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Serial Mouse in Kernel 2.6
Message-Id: <20050429145248.3551b9ea.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When configuring Kernel 2.6.11.7, I found under Input Devices two
options which seem to have to do with serial mouse support:

1. Serial line discipline (module serport)
2. Serial Mouse support (module sermouse)

Ic compiled both these features as a module. But after rebooting with
the new kernel, the serial mouse is working well with gpm and with X11,
although none of the above modules are loaded.

So, what for are the modules mentioned above needed?

Kind regards
  Christoph
