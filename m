Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263025AbTCURm7>; Fri, 21 Mar 2003 12:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbTCURm7>; Fri, 21 Mar 2003 12:42:59 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:53152 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263025AbTCURm6>; Fri, 21 Mar 2003 12:42:58 -0500
Date: Fri, 21 Mar 2003 17:53:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65: 3C905 driver doesn't work.
Message-ID: <20030321175356.GC15652@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jos Hulzink <josh@stack.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303211618.36485.josh@stack.nl> <20030321153704.GA3762@suse.de> <20030321182933.E11076-100000@snail.stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321182933.E11076-100000@snail.stack.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 06:31:24PM +0100, Jos Hulzink wrote:
 > > "acpi=off noapic"
 > > For me, the third one gets it working again on two boxes.
 > > Without that, packets are sent, but nothing is ever recieved.
 > For me, the third option results in a kernel panic very early during boot
 > :( I'm trying to get more info out of it.

Interesting, can you post that panic ?

		Dave

