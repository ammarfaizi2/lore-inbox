Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTE0NgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTE0NgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:36:07 -0400
Received: from mail.ithnet.com ([217.64.64.8]:8198 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263542AbTE0NgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:36:06 -0400
Date: Tue, 27 May 2003 15:49:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Werner.Beck@Lidl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in Kernel 2.4.21-rc1
Message-Id: <20030527154910.451e83d8.skraw@ithnet.com>
In-Reply-To: <OF4CB12D76.81223041-ONC1256D33.0040CFEC-C1256D33.004202DC@eu.lidl.net>
References: <OF4CB12D76.81223041-ONC1256D33.0040CFEC-C1256D33.004202DC@eu.lidl.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 14:01:00 +0200
Werner.Beck@Lidl.de wrote:

> Hello,
> I encountered a Kernel oops on two different PCs, both a configured
> identical. The system uses an ISDN connection to an Internet ISP and then
> establishes a VPN tunnel based on PPTP.
> As far as I can see in /var/log/messages the problem occurred on both
> system at the same time at 00:15, but not at the same day and not every
> day. No special program is running at that time. Basically it is a SuSE 7.3
> distribution, I made a Kernel upgrade.
> Hardware is a Fujitsu Siemens N300 PC with an IDE (7200 Rpm), Intel 845GI
> Motherboard, an ISDN PBX connected via USB to dial-up, the connection
> wasn't established when the system oopsed.
> Attached are some information.
> (See attached file: info.txt)(See attached file: oops.log)

Exchange the USB/ISDN part with a pci card and re-try with kernel -rc4. 

Tell us if that works.

Regards,
Stephan
