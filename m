Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbUKRUtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbUKRUtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUKRUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:49:07 -0500
Received: from gold.pobox.com ([208.210.124.73]:61378 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S262906AbUKRUsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:48:52 -0500
Date: Thu, 18 Nov 2004 12:48:41 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-rc4
Message-ID: <20041118204841.GA11682@ip68-4-98-123.oc.oc.cox.net>
References: <419B1813.80002@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419B1813.80002@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:21:23AM +0200, O.Sezer wrote:
> >Jakub Jelínek:
> >  o binfmt_elf: handle p_filesz == 0 on PT_INTERP section
> 
> Another FYI: There were two successive binfmt_elf 2.6-backports posted
> by Barry Nathan here;  "ELF fixes for executables with huge BSS":
> 
> http://marc.theaimsgroup.com/?t=109850369800001&r=1&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420711579&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420729735&w=2
> 
> but it may be too late for 2.4.28.

Marcelo and I discussed this via private e-mail; it's in the queue for
2.4.29-pre. I think in the end we both agreed that it's too late in the
2.4.28 cycle to include these patches.

-Barry K. Nathan <barryn@pobox.com>

