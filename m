Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUFPAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUFPAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUFPAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:14:57 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:56754 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S266028AbUFPAO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:14:56 -0400
Message-ID: <40CF90C5.7050907@pacbell.net>
Date: Tue, 15 Jun 2004 17:13:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: John Carlson <carlsj@yahoo.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] Usb gadget drivers 2.4 kernel
References: <20040614133218.53174.qmail@web41013.mail.yahoo.com>
In-Reply-To: <20040614133218.53174.qmail@web41013.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Carlson wrote:
> While developing a gadget driver for the 2.4 kernel, I
> discovered this error in the gadget driver.  This bug
> has been present since the gadget driver was back
> ported from the 2.6 kernel.

Actually, it's just that one source file (config.c),
and the fix is in the gadget-2.4 tree already.  I'll
have to resubmit this one, it's rather annoying to
anyone trying to make sure their new hardware works!

- Dave



