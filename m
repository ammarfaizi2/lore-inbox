Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTGGQel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbTGGQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:34:40 -0400
Received: from smtp2.libero.it ([193.70.192.52]:22153 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265055AbTGGQej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:34:39 -0400
Subject: [RFC] [PATCH] LIRC drivers for 2.5
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1057596609.1144.5.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 07 Jul 2003 18:50:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch can be grabbed from
http://flameeyes.web.ctonet.it/patch-2.5.72-lirc.diff.bz2

This patch (that apply over .72+ but probably also in previous
versions), adds the LIRC drivers (http://lirc.sf.net/) from the cvs to
the kernel.
As userland tools can be used lirc (from cvs) build against a 2.4
kernel.
I've tested it with my tv card for some weeks and it works perfectly.

I hope can be useful.

[Sorry if this is a double message, my isp's mailserver has some problems, I receive an error back from it, but i'm not sure if it's true or a false warning. In case, sorry]

-- 
Flameeyes <dgp85@users.sf.net>

