Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVFTTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVFTTIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVFTTIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:08:20 -0400
Received: from mail.linicks.net ([217.204.244.146]:55818 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261501AbVFTTAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:00:14 -0400
From: Nick Warne <nick@linicks.net>
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Mon, 20 Jun 2005 20:00:08 +0100
User-Agent: KMail/1.8.1
References: <200506181332.25287.nick@linicks.net> <42B6FBC7.5000900@pobox.com> <20050620173411.GB15212@suse.de>
In-Reply-To: <20050620173411.GB15212@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202000.08114.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 18:34, you wrote:

> As for working with people's boxes, only the very oldest versions of
> udev (like the reported 030 version which is a year old and I do not
> think shipped by any distro) would have the "lockup" issue.  On all of
> the other ones, only custom rules written by users would have issues
> (meaning, not work).  I do not know of any shipping, supported distro
> that currently has a boot lockup issue (if so, please let me know.)

It appears the issue people are seeing is with Slack 10, which shipped with 
udev 0.26 - and I presume there was 'custom' rules Patrick had built in.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
