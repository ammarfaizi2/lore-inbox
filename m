Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUIMPxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUIMPxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268671AbUIMPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:45:20 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2183
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268565AbUIMPmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:42:14 -0400
Message-Id: <s145cde4.009@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 13 Sep 2004 17:42:43 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: hardware breakpoints questions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Why is it that user mode has to have knowledge about the layout and
number of debug registers?
- Why is it that (on i386/x86-64) one can't, say, set a byte-range
breakpoint on TASK_SIZE - 1 (whatever this may be good for)?
- Why is it that (on i386/x86-64) one can't set 2- or 4-byte-range
execution breakpoints, but one can (on x86-64) set 8-byte-range ones?

Thanks, Jan
