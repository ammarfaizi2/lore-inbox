Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTKCSin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTKCSin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:38:43 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:59372 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262158AbTKCSim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:38:42 -0500
Message-ID: <3FA6A0AF.2070300@softhome.net>
Date: Mon, 03 Nov 2003 19:38:39 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How provoke call stack trace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

    [ Simple question. Probably FAQ - but I cannot find it. ]

    How can I print call stack trace, just like BUG() does?
    But without asm(".long 0") as BUG() does.

    Is there any function which can be used by module to just 
investigate some given call path?

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

