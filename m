Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFKVNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTFKVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:13:27 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:11020 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264500AbTFKVMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:12:36 -0400
Date: Wed, 11 Jun 2003 22:26:19 +0100
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oprofile broken by sysfs updates
Message-ID: <20030611212619.GA67428@compsoc.man.ac.uk>
References: <20030611211220.GA634@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611211220.GA634@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QD6q-00094J-1O*MAUnrCOyAG6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 11:12:20PM +0200, Pavel Machek wrote:

> arch/i386/oprofile/nmi_int.c must be suspended before
> arch/i386/kernel/apic.c is.
> 
> How is that guaranteed with new code?

http://marc.theaimsgroup.com/?l=linux-kernel&m=105517556119093&w=2

regards
john
