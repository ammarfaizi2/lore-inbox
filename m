Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWJ2MqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWJ2MqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWJ2MqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:46:21 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:4503 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965170AbWJ2MqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:46:20 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 29 Oct 2006 07:44:18 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why test for "__GNUC__"?
In-Reply-To: <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain>
 <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006, Jan Engelhardt wrote:

>
> >  since (as i understand it) the linux kernel *requires* gcc these
> >days, what is the point of the numerous preprocessor tests of the
> >form:
>
> ICC is said to work too.

ah, i was not aware of that.  but does that mean that ICC is (or will
be) *officially* supported?  or does it just *happen* to work at the
moment with no guarantees of future compatibility?

rday

p.s.  is there, in fact, any part of the kernel source tree that has a
preprocessor directive to identify the use of ICC?  just curious.
