Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTJFAjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTJFAjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:39:52 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:18125 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S263911AbTJFAjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:39:51 -0400
Date: Sun, 5 Oct 2003 20:39:47 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: drivers/usb/core/message.c: error getting string descriptor 0 (error=-110) 
Message-ID: <20031006003844.GA23136@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

Previousely I reported a problem on my vaio laptop: 'irq 9: nobody
cared', and all the ideas seems didn't help me (besides reversing all
changes of bk4-bk5 usb changes).

Now I've tried recent test6-bk7 and from the 1st sight everything
worked: usb mouse came alive but then nothing else really worked, nor
usb palm, neither usb camera. The only error I'm getting 

drivers/usb/core/message.c: error getting string descriptor 0 (error=-110)

more details in

http://www.onerussian.com/Linux/bugs/nousb

What it can be?
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
