Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVBLUrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVBLUrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVBLUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 15:47:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261196AbVBLUrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 15:47:18 -0500
Date: Sat, 12 Feb 2005 15:47:07 -0500
From: Dave Jones <davej@redhat.com>
To: Marcus Hartig <m.f.h@web.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
Message-ID: <20050212204707.GC18180@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcus Hartig <m.f.h@web.de>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <420E4812.7000006@web.de> <1108232773.4056.120.camel@localhost.localdomain> <420E5AAD.7080206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420E5AAD.7080206@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 08:36:13PM +0100, Marcus Hartig wrote:
 > Arjan van de Ven wrote:
 > 
 > >hmm I wonder.. .could you collect lspci -vxxx settings for the AGP
 > >device (lspci -vxxx gives you lots of devices, but only one is relevant)
 > >in both cases, maybe the difference between the two shows something
 > >useful...
 > 
 > Hmmm...only the latency at the VGA card.

Was there any differnces in the devices at 00:00.0 and 00:01.0 ?
(host & pci bridges)

		Dave

