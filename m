Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUGNDWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUGNDWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUGNDWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:22:18 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:5044 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S267312AbUGNDWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:22:13 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040714024020.GS21066@holomorphy.com>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714024020.GS21066@holomorphy.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089775227.15336.2523.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 20:20:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 19:40, William Lee Irwin III wrote:

> > This box has 4G memory and running without swap (what I would need it
> > for If I can only use up to 3GB address space in the application anyway)
> 
> Is this a regression from earlier 2.6 versions? Do you have an isolated
> testcase (obviously I should be able to install mysql easily) I can use
> to trigger this?

Not yet.  I've been doing various MySQL tests with various kernels and
this is the first time I see such behavior.

If It will repeat itself I will try to isolate it to the test case,
so fat I just wanted to report it to see if this is known or expected
issue.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



