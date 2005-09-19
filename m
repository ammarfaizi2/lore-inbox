Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVISM4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVISM4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 08:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVISM4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 08:56:00 -0400
Received: from [81.2.110.250] ([81.2.110.250]:45459 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932311AbVISM4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 08:56:00 -0400
Subject: Re: [TG3]: Add AMD K8 to list of write-reorder chipsets.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: arjanv@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1127132518.3019.8.camel@localhost.localdomain>
References: <200509182159.j8ILxdDB030369@hera.kernel.org>
	 <1127132518.3019.8.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 14:21:52 +0100
Message-Id: <1127136112.22124.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-19 at 08:21 -0400, Arjan van de Ven wrote:
> shouldn't something like this move to generic code?
> (and in this case, probably as quirk that disables the chipset
> "feature" ?)

You don't normally want to disable this feature of chipsets, it just
gives the tg3 indigestion. 

Alan

