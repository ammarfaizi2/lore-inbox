Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270481AbUJUKvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270481AbUJUKvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270635AbUJUKtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:49:03 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17628 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270481AbUJUKrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:47:08 -0400
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41776F2A.1080707@t-online.de>
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>
	 <417660AE.4060408@t-online.de>
	 <1098301207.12411.35.camel@localhost.localdomain>
	 <41776F2A.1080707@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098351855.17095.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:44:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 09:11, Harald Dunkel wrote:
> I am not a kernel developer. I just modified Vojtech's patch
> for 2.6.9. His patch works for me since 2.6.7.
> 
> But it seems that UHCI _is_ handled, isn't it?

Braino .. I meant EHCI

