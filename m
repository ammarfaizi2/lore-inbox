Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWIYNcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWIYNcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIYNcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:32:16 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:38370 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750993AbWIYNcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:32:15 -0400
Message-ID: <4517DA5E.4050709@cmu.edu>
Date: Mon, 25 Sep 2006 09:32:14 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060821)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: no status when suspending to disk
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

Whenever I suspend to disk without quitting X first, I do not get a
status, ie. 58%

I updated my kernel a couple weeks ago and it miraculously came up, I
was able to get a status when using the kernel.

Then when I just recently updated my kernel again it went away.

All I get now is a blank, but lit, LCD screen with a blinking cursor at
the very top left.

How can I get it to display the status?

Thanks!
George
