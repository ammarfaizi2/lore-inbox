Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTJAWEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTJAWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:04:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58121 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262680AbTJAWEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:04:12 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] [TRIVIAL 1/12] 2.6.0-test6-bk remove reference to
	modules.txt in drivers/atm/Kconfig
Date: 1 Oct 2003 21:54:40 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blfif0$jf0$1@gatekeeper.tmr.com>
References: <1065024797.1995.2335.camel@spc9.esa.lanl.gov>
X-Trace: gatekeeper.tmr.com 1065045280 19936 192.168.12.62 (1 Oct 2003 21:54:40 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1065024797.1995.2335.camel@spc9.esa.lanl.gov>,
Steven Cole  <elenstev@mesatop.com> wrote:
| This patch removes the reference to Documentation/modules.txt,
| which has been removed.  The patch was made against the current
| 2.6-bk tree.

Would it be better to point to the current location of the information?
Or put a revised modules.txt in place?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
