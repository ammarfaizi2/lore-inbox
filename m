Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbTGOSoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbTGOSox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:44:53 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:1920 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S269412AbTGOSng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:43:36 -0400
Date: Tue, 15 Jul 2003 20:58:52 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715185852.GA519@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones <davej@codemonkey.org.uk> [2003-07-15 20:33:00]:
>> CONFIG_INPUT=m
> Because this is m, Kconfig is hiding CONFIG_VT from you.

When I read the help for CONFIG_VT, I was convinced that was it, but
when I tried to enable CONFIG_VT it still didn't work. It just sounded
so like that was it. Any other suggestions?

By the way.. I am subscribed to this list now, so no need to CC anymore,
but thanks for the reply.

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>
