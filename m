Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTGUTdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTGUTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:33:54 -0400
Received: from smtp.terra.es ([213.4.129.129]:56621 "EHLO tfsmtp3.mail.isp")
	by vger.kernel.org with ESMTP id S270705AbTGUTdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:33:50 -0400
From: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
To: linux-kernel@vger.kernel.org
Message-ID: <667ff6ab37.6ab37667ff@teleline.es>
Date: Mon, 21 Jul 2003 21:48:49 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might be posible to implement in user space. I have not fully studied
it to see if there are significant problems.

I believe that innovation is a public good that should be actively
promoted. Otherwise technology would never advance.

The complication added to the kernel is minimal because the primitive is
simple. That is actually the most important reason why I like it.

There are barriers to adopting, such as portability. But if the
primitive is included in standard Linux and is found useful by
application developers, other Unixes will follow.

Ramon



