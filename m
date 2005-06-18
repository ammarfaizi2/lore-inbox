Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVFRTFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVFRTFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVFRTFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:05:38 -0400
Received: from mail.linicks.net ([217.204.244.146]:6675 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262163AbVFRTFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:05:30 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12
Date: Sat, 18 Jun 2005 20:05:28 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506182005.28254.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt () goodmis ! org> wrote:

> This is somewhat experimental at this time, but it should be safe,
> as long as you aren't building this as a module and then removing it.

> If unsure, say Y. Do not say M.

>  USB Monitor (USB_MON) [M/n/?] (NEW)
> --------------

> I really like my options. :-)

> OK, I have CONFIG_USB as a module, but I really thought that this was
> pretty amusing.

Heh.  When I was sussing 2.6.12 stuff today, I really thought it was me 
buggering up something.  So after reading a lot, I wondered (neurotically)  
if I was doing anything wrong (after all this time, it's likely).

> make help reveals:

 randconfig      - New config with random answer to all options

So 'make randconfig' is the one to use!  What one earth is that for?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
