Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUEXExl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUEXExl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUEXExk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:53:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:17127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbUEXExj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:53:39 -0400
Date: Sun, 23 May 2004 21:50:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [announce/OT] kerneltop ver. 0.7
Message-Id: <20040523215027.5dc99711.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just a little note about kerneltop...

'kerneltop' is similar to 'top', but shows only kernel function usage
(modules not included).

I have updated it a bit (now version 0.7) and made sure that it
works OK on Linux 2.6.x.

It's available here:
	http://www.xenotime.net/linux/kerneltop/

--
~Randy

changelog:
version 0.6 (never released/announced):
 * . add interactive keyboard inputs for l(ines), s(econds), t(icks),
 *   u(nsort), h(elp) or ?(help), q(uit)

version 0.7:
 * . make a difference in profile_lines and console_lines; they were
 *   the same, which caused some heading lines to scroll off the
 *   top of the console and make general garbage of the headings;
 * . reduce the fixed heading info by 2 lines (no version, no dash line);

