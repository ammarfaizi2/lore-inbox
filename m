Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFTG4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 02:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFTG4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 02:56:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62734 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262148AbTFTG4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 02:56:25 -0400
Date: Fri, 20 Jun 2003 08:10:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030620081021.C7431@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com> <20030619093632.A29602@flint.arm.linux.org.uk> <20030619234249.GA31392@neo.rr.com> <20030620065547.B7431@flint.arm.linux.org.uk> <20030620061020.GC786@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030620061020.GC786@pazke>; from pazke@donpac.ru on Fri, Jun 20, 2003 at 10:10:20AM +0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 10:10:20AM +0400, Andrey Panin wrote:
> It was me who added this crappy quirk.

It helps when the people with the problems are reading the list. 8)

> My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+Voice
> Modem" was going mad when its IRQ was shared with any device. So I decided
> to add this quirk.

Can you remember any further details?  Eg, was it when sharing with other
serial ports (and were these serial ports in use), or any thing else?

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

