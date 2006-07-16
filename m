Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGPT00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGPT00 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWGPT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:26:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:63903 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751175AbWGPT00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:26:26 -0400
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <1153077550.5905.33.camel@localhost.localdomain>
References: <20060716163728.GA16228@suse.de>
	 <20060716165004.GA16369@suse.de>
	 <1153077550.5905.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:25:53 -0400
Message-Id: <1153077953.5905.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, that looks like some serious bogosity in that code. Care to send a
> patch ?

(I'm in a hotel room in Ottawa with no r128 at hand to test so I'm not
doing it myself just now :)

Ben.


