Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJIA3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTJIA3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:29:34 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:23745 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261850AbTJIA3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:29:33 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20031009002318.GB219@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk>
	 <20031005161155.GA753@elf.ucw.cz>
	 <20031005171916.B21478@flint.arm.linux.org.uk>
	 <20031005191344.GA963@elf.ucw.cz>
	 <1065384453.3157.149.camel@imladris.demon.co.uk>
	 <20031009002318.GB219@elf.ucw.cz>
Message-Id: <1065659366.30987.178.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Thu, 09 Oct 2003 01:29:26 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: [pm] Re: JFFS2 swsusp / signal cleanup.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you need locking for recalc_sigpending()?

-- 
dwmw2


