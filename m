Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTFVBoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTFVBoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 21:44:46 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:11751 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S265429AbTFVBop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 21:44:45 -0400
Message-ID: <3EF50D43.6020809@xfree86.org>
Date: Sun, 22 Jun 2003 03:58:27 +0200
From: Thomas Winischhofer <twini@xfree86.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en, de-at, de-de, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SiS IRQ router 96x detection (2.5.69) ...
References: <Pine.LNX.4.55.0306022338530.3631@bigblue.dev.mcafeelabs.com>  <3EF248F9.7040402@winischhofer.net> <1056198220.25975.23.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55.0306211314400.3725@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0306211314400.3725@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> I have to admit that I was tempted to let this go through by simply
> ignoring you. 

Ouch, this hurts. The lawyer in me just told me that this is no proper 
way to argue. And he means both sides. I think he's right.

Davide, calm down and take a deep breath. Better? :) Alan probably 
receives thousands of mails every day and he therefore tends to make it 
somewhat very short sometimes. Be happy that he even aswered at all, right?

You got a point, though. The only issue Alan mentioned was the NULL 
initialisation.

Let's give Alan another chance to explain (shortly) why he thought your 
patch was ugly - would you, Alan?

Point is, this is a serious issue. IRQ routing is nothing that should be
decided over beauty. Alan, you obviously saw the code. Are you perhaps 
willing to make a better patch if you're that unsatisfied with the 
current one?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org

