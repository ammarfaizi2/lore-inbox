Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVFHLNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVFHLNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFHLNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:13:41 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3223 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262170AbVFHLNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:13:36 -0400
Date: Wed, 8 Jun 2005 13:15:03 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20050608111503.GA5777@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607091144.GA5701@linuxtv.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.245.163
Subject: Re: Linux v2.6.12-rc6
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> Hype-threading stopped working for me (probably due to
> me not enabling ACPI). dmesg output and .config attached.
> -rc5 worked fine. The board is an Asus P4P800-Deluxe.
> 
> dmesg: WARNING: 1 siblings found for CPU0, should be 2

Indeed SMT works fine if I enable ACPI.
Is SMT without ACPI not supported?

Johannes
