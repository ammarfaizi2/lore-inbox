Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUB0Rvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbUB0Rvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:51:35 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:37298 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263089AbUB0RuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:50:07 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Feb 2004 17:50:03 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <403F834B.8112.2443EF92@localhost>
In-reply-to: <200402271040.20721.lkml@lpbproductions.com>
References: <403F7EEF.4124.2432E62F@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If your using acpi , boot up with either
> acpi=ht
> or
> acpi=nopci
> 
> 
> Matt H.

I do not have apci compiled.

# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

Also I forgot to mention, 'noapic' makes no difference either.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble,
Give a whistle
And this'll help things turn out for the best."

