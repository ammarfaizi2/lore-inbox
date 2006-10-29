Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWJ2X1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWJ2X1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWJ2X1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:27:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:21702 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030439AbWJ2X1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:27:21 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <454538AA.9000104@s5r6.in-berlin.de>
Date: Mon, 30 Oct 2006 00:26:34 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Paprocki <andrew@ishiboo.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6 git kernel reporting bug in knodemgrd_0 during boot
References: <76366b180610291341y7342a968ycd244753ce9bbbb7@mail.gmail.com> <20061029223822.GH27968@stusta.de> <4545349C.1070009@s5r6.in-berlin.de>
In-Reply-To: <4545349C.1070009@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>> On Sun, Oct 29, 2006 at 04:41:54PM -0500, Andrew Paprocki wrote:
>>> I just upgraded my dev box to the latest 2.6 source via git and this
>>> is now printing out in dmesg upon every boot.
> ...
> Andrew, what was the last kernel which didn't log this?

And did you change any of the IEEE1394 options in the kernel configuration?
-- 
Stefan Richter
-=====-=-==- =-=- ====-
http://arcgraph.de/sr/
