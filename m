Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVJBSHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVJBSHc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJBSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:07:32 -0400
Received: from w240.dkm.cz ([62.24.88.240]:47767 "EHLO
	hathor.home.spitalnik.net") by vger.kernel.org with ESMTP
	id S1751149AbVJBSHc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:07:32 -0400
From: Jan Spitalnik <lkml@spitalnik.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: thinkpad suspend to ram and backlight
Date: Sun, 2 Oct 2005 20:07:29 +0200
User-Agent: KMail/1.8.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
References: <20051002175703.GA3141@elf.ucw.cz>
In-Reply-To: <20051002175703.GA3141@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510022007.29660.lkml@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ne 2. øíjna 2005 19:57 Pavel Machek napsal(a):
> Hi!
>
> When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> video chips is not turned off, too). Unfortunately, backlight is not
> turned even when lid is closed. I know some patches were floating
> around to solve that... but I can't find them now. Any ideas?
> 								Pavel

Hi,

if your thinkpad has ati radeon, you can use this:

http://www.thinkwiki.org/wiki/Radeontool

-- 
Jan Spitalnik
jan@spitalnik.net
