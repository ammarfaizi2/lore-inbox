Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVFRRIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVFRRIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 13:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVFRRIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 13:08:48 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:58585 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262162AbVFRRIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 13:08:38 -0400
Date: Sat, 18 Jun 2005 19:10:15 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20050618171015.GA20845@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org> <20050608111503.GA5777@linuxtv.org> <42A6D521.606@ens-lyon.org> <20050608113718.GA5949@linuxtv.org> <42B30CE9.4050707@tmr.com> <20050618135752.GB19838@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050618135752.GB19838@linuxtv.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.217.46
Subject: Re: Linux v2.6.12-rc6
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> In 2.6.12-rc5 SMT worked without CONFIG_ACPI. (IIRC the kernel used some
> minimal ACPI stuff anyway for CPU initialisation).
> 
> I don't use power management or other features of ACPI so I
> had it disabled, and my build broke with 2.6.12-rc6.

Correction: It built fine, but didn't recognize the second "CPU".

Johannes
