Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTGUNBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbTGUNBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:01:20 -0400
Received: from zork.zork.net ([64.81.246.102]:58291 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S270040AbTGUNBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:01:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 - device_suspend KERN_EMERG message?
References: <9cffzl0nia3.fsf@rogue.ncsl.nist.gov>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2003 14:16:06 +0100
In-Reply-To: <9cffzl0nia3.fsf@rogue.ncsl.nist.gov> (Ian Soboroff's message
 of "Mon, 21 Jul 2003 09:03:48 -0400")
Message-ID: <6uel0k58bt.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <ian.soboroff@nist.gov> writes:

> On my box, syslog shouts to all xterms and KDE throws up a kwrite message
> too.  Why is this an emergency?  If there are no objections, I'll send
> a patch to move these messages to KERN_NOTICE.

I think I saw a patch posted recently that deletes them entirely.

