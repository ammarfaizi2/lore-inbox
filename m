Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWJAIWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWJAIWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWJAIWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 04:22:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:12448 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751499AbWJAIWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 04:22:49 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <451F7A59.4020803@s5r6.in-berlin.de>
Date: Sun, 01 Oct 2006 10:20:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Miguel Ojeda <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>	<20060930123547.d055383f.rdunlap@xenotime.net>	<451EE36C.5080002@s5r6.in-berlin.de>	<20060930144830.eba63268.rdunlap@xenotime.net>	<653402b90609301545y2d4f162dq824ac360149fc0a7@mail.gmail.com> <20060930155250.8cae208b.rdunlap@xenotime.net>
In-Reply-To: <20060930155250.8cae208b.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Sat, 30 Sep 2006 22:45:56 +0000 Miguel Ojeda wrote:
...
>> 	tristate "CFAG12864B LCD Display"
> 
> That seems very common to me.

It is as common as it is wrong. http://en.wikipedia.org/wiki/RAS_Syndrome

...
>> LCDisplay??

A contraction like LCDisplay, like my suggested lcdisplay for the path
name, is IMO not suitable for use in normal written language. Use it at
most for path names where we contract words into one or would write
lc-display or lc_display.

> I would continue to use LCD display (small d).

Still wrong language.

"LCD" and "LC display" are correct.
-- 
Stefan Richter
-=====-=-==- =-=- ----=
http://arcgraph.de/sr/
