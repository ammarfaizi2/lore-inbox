Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272072AbTHDSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272073AbTHDSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:13:59 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:6885 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S272072AbTHDSN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:13:58 -0400
Date: Mon, 4 Aug 2003 20:13:07 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre10 Problems with radeonfb and suspend mode
Message-ID: <20030804181307.GB31178@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19jjpU-00087s-00*zHhUtEnfX7.* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        hello,

If i load the radeonfb module and send my thinkpad with apm -s to
suspend all seems fine but on comming back the screen is still black.

Kernel: 2.4.22-pre10 
Hardware: Thinkpad R40 2722 / Sony Z1
          01:00.0 VGA compatible controller: ATI Technologies Inc 
          Radeon Mobility M7 LW [Radeon Mobility 7500]

        Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
