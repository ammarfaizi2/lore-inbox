Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTEIV6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbTEIV6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:58:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62982 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263510AbTEIV63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:58:29 -0400
Date: Fri, 9 May 2003 23:11:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: no console found booting 2.5.69
Message-ID: <20030509231105.D5204@flint.arm.linux.org.uk>
Mail-Followup-To: Pau Aliagas <linuxnow@newtral.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305091844370.1574-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305091844370.1574-100000@pau.intranet.ct>; from linuxnow@newtral.org on Fri, May 09, 2003 at 06:47:59PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 06:47:59PM +0200, Pau Aliagas wrote:
> Another problem is the PCMCIA that I already reported for 2.5.68; it 
> stalls if I don't remove the Cardbus card.

I never got around to sending the patch because I only received one
report.  Please try the patch found at:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=105162599105406&w=2

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

