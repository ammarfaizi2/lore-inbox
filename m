Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTHCGwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 02:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTHCGwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 02:52:54 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:17793 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S271033AbTHCGwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 02:52:53 -0400
Date: Sun, 3 Aug 2003 10:49:37 +0400
Message-Id: <200308030649.h736nbcj013727@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.6.0-test2: crash in reiserfs at shutdown
To: harri@synopsys.com, linux-kernel@vger.kernel.org
References: <3F2B9823.7010503@Synopsys.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Harald Dunkel <harri@synopsys.com> wrote:

HD> Final words are
HD>         kernel BUG at fs/reiserfs/prints.c: 339

There should be one line prior to that.
This line explains what went wrong in reiserfs opinion.
Can you please say us what was the line?

Bye,
    Oleg
