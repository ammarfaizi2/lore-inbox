Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUCXOBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbUCXOBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:01:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:44047 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263380AbUCXOBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:01:38 -0500
Message-ID: <406194D4.9030904@aitel.hist.no>
Date: Wed, 24 Mar 2004 15:01:56 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
References: <20040323232511.1346842a.akpm@osdl.org>
In-Reply-To: <20040323232511.1346842a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

2.6.5-rc2-mm2 hung during boot for me.
The last messages was
Setting up ICE socket directory ... done

which is from the xserver-common init script.
Then I got a line saying
INIT:

and nothing more happened.  The capslock and numlock keys
toggled their LEDs, and that was it.  The only sysrq sequence
working was sysrq+B, so I booted it.

Then I tried 2.6.5-rc2-mm2 single-user.
I acutally got the command prompt, everything seemed ok,
but then I ran "init 2", got the message about
killing processes and nothing more happened again.
There were no "INIT:" message this time.

2.6.5-rc1-mm2 works.

Helge Hafting


