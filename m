Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTHXXTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 19:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTHXXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 19:19:35 -0400
Received: from main.gmane.org ([80.91.224.249]:5006 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261334AbTHXXTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 19:19:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: [2.6] i8042 module prevents APM suspend on ThinkPad 770
Date: Sun, 24 Aug 2003 19:19:39 -0400
Message-ID: <bibh63$eqb$1@sea.gmane.org>
References: <3F494394.3020700@ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <3F494394.3020700@ghz.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2nd paragraph should have been:

> In 2.5.31, I could get by with the old keyboard driver. However, in
> later kernels (continuing through 2.6.0-test3), unless I make the 
> i8042 driver a module, and (warning: kludge ahead) have the APM 
> scripts remove and reinsert it before and after suspend, the APM BIOS
> rejects the suspend request.

-C


