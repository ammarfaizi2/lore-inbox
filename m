Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWI1Rot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWI1Rot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWI1Rot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:44:49 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:54533 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030326AbWI1Ros
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:44:48 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Michael Obster <lkm@obster.org>
Subject: Re: OT: linux-kernel list and greylisting
Date: Thu, 28 Sep 2006 19:46:11 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <451BFF6F.2050602@obster.org>
In-Reply-To: <451BFF6F.2050602@obster.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281946.11845.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> anyone here who has experience with greylisting and the linux-kernel
> list? I want to configure greylisting on my server but I don't know if
> this setting is compatible with the list here.
> What I want to avoid is a massive bounce because of that! So please give
> me feedback, if greylisting is a problem for the list.

Greylisting relayed traffic is useless. Greyslisting is also expensive (delays 
and bounces) so probably that's not what you want. Anyway if you know what 
you are doing ;-) take a look at this:

http://aisk.tuxland.pl/os-fp-vs-spam-src.html

OS based greylisting is a compromise. Gives great results with minimal costs 
to most of incoming traffic.

Regards,

	Mariusz Kozlowski
