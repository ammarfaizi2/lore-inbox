Return-Path: <linux-kernel-owner+w=401wt.eu-S932528AbWLNUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWLNUI5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWLNUI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:08:56 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:1500 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528AbWLNUI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:08:56 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 12:08:11 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20061214153949.GA3388@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 14 Dec 2006 13:11:27 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 14 Dec 2006 13:11:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And there's also the common misconception all costumers had enough
> information when buying something. If you are a normal Linux user and
> buy some hardware labelled "runs under Linux", it could turn out that's
> with a Windows driver running under ndiswrapper...

That is something that I think is well worth fixing. Doesn't Linus own the
trademark 'Linux'? How about some rules for use of that trademark and a
'Works with Linux' logo that can only be used if the hardware specifications
are provided?

Let them provide a closed-source driver if they want. Let them provide
user-space applications for which no source is provided if they want. But
don't let them use the logo unless they release sufficient information to
allow people to develop their own drivers and applications to interface with
the hardware.

That makes it clear that it's not about giving us the fruits of years of
your own work but that it's about enabling us to do our own work. (I would
have no objection to also requiring them to provide a minimal open-source
driver. I'm not trying to work out the exact terms here, just get the idea
out.)

DS


